(ns run-length-encoding)

(defn group-by-runs [plain-text]
  (partition-by identity plain-text))

(defn remove-repeated-chars [runs]
  (map dedupe runs))

(defn count-run-length [runs]
  (doall (map count runs)))

(defn ignore-single-char-run-counts [runs]
  runs)

(defn match-run-length-with-run [run-lengths runs]
  (clojure.string/replace
   (apply str
          (flatten
           (interleave run-lengths runs)))
   " " ""))

(defn run-length-encode
  "encodes a string with run-length-encoding"
  [plain-text]
  (let [runs (group-by-runs plain-text)]
    (match-run-length-with-run
     (count-run-length runs)
     (remove-repeated-chars runs))))

(defn run-length-decode
  "decodes a run-length-encoded string"
  [cipher-text]
  cipher-text)

(map #(clojure.string/replace % "1" "") (count-run-length (group-by-runs "AABBBCCCCA")))

(remove #(= % 1) (count-run-length (group-by-runs "AABBBCCCCA")))

(into () (ignore-single-char-run-counts (count-run-length (group-by-runs "AABBBCCCCA"))))

(seq (count-run-length (group-by-runs "AABBBCCCCA")))

(into () (ignore-single-char-run-counts (count-run-length (group-by-runs "AABBBCCCCA"))))
(ignore-single-char-run-counts (count-run-length (group-by-runs "AABBBCCCCA")))
(ignore-single-char-run-counts '(2 3 4 1))

(type (count-run-length (group-by-runs "AABBBCCCC")))

(second (ignore-single-char-run-counts (count-run-length (group-by-runs "AABBBCCCC"))))

(remove-repeated-chars (group-by-runs "AABBBCCCC"))

(run-length-encode "AABBCCCC")

(match-run-length-with-run  '("2" "3" "4" " ") '("A" "B" "C" "D"))

(doall (map count (group-by-runs "AABBCCCCA")))
(first (map count (group-by-runs "AABBCCCCA")))