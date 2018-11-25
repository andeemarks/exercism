(ns word-count)

(defn word-count [s]
  (->> s
    (clojure.string/lower-case)
    (re-seq #"\w+")
    (frequencies)))