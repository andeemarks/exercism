(ns run-length-encoding)

(defn- group-by-runs [plain-text] (partition-by identity plain-text))
(defn- remove-repeated-chars [runs] (map dedupe runs))
(defn- count-run-length [runs] (doall (map count runs)))
(defn- abbrev-single-char-runs [runs] (remove #(= % 1) runs))

(defn- match-run-length-with-run [run-lengths runs]
  (apply str
         (flatten
          (abbrev-single-char-runs
           (interleave run-lengths runs)))))

(defn run-length-encode
  "encodes a string with run-length-encoding"
  [plain-text]
  (let [runs (group-by-runs plain-text)]
    (match-run-length-with-run
     (count-run-length runs)
     (remove-repeated-chars runs))))

(defn- run-length [component] (Integer/parseInt (first (re-seq #"\d+" component))))
(defn- run-value [component] (first (re-seq #"[^\d]+" component)))
(defn- run [length value] (apply str (repeat length (get value 0))))

(defn- component-to-run [component]
  (let [length (run-length component)
        value (run-value component)
        run (run length value)]
    (if (<= 1 (count value))
      (str run (apply str (rest value)))
      run)))

(defn run-length-decode
  "decodes a run-length-encoded string"
  [cipher-text]
  (let [components (re-seq #"\d+[^\d]+" cipher-text)]
    (if (nil? components)
      cipher-text
      (apply str (map #(component-to-run %) components)))))