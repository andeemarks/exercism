(ns matching-brackets)

(defn- remove-adjacent-term-pairs [s]
  (let [new-s
        (-> s
            (clojure.string/replace #"\{\}" "")
            (clojure.string/replace #"\[\]" "")
            (clojure.string/replace #"\(\)" ""))]
    (if (< (count new-s) (count s)) ;; removal reduced size of s -> potentially more to remove
      (remove-adjacent-term-pairs new-s)
      new-s)))

(defn- unmatched-terms? [s] (empty? (remove-adjacent-term-pairs s)))
(defn- remove-non-terms [s] (clojure.string/replace s #"[^\}\{\(\)\[\]]+" ""))

(defn valid? [s]
  (unmatched-terms? (remove-non-terms s)))
