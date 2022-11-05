(ns rna-transcription)

(def mappings (hash-map "C" "G" "G" "C" "A" "U" "T" "A"))

(defn to-rna [dna] ;; <- arglist goes here
  (let [rna (map #(get mappings (str %)) dna)]
    (if (some nil? rna)
      (throw (AssertionError. "Wrong input."))
      (apply str rna))))
