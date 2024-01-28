(ns protein-translation)

(def translations {"AUG", "Methionine"

                   "UUU", "Phenylalanine"
                   "UUC", "Phenylalanine"
                   "UUA", "Leucine"
                   "UUG", "Leucine"
                   "UCU", "Serine"
                   "UCC", "Serine"
                   "UCA", "Serine"
                   "UCG", "Serine"
                   "UAU", "Tyrosine"
                   "UAC", "Tyrosine"
                   "UGU", "Cysteine"
                   "UGC", "Cysteine"
                   "UAA", "STOP"
                   "UAG", "STOP"
                   "UGA", "STOP"
                   "UGG", "Tryptophan"})

(defn translate-codon [codon]
  (get translations codon))

(defn translate-rna [rna]
  (let [codons (map (partial apply str) (partition-all 3 rna))
        translations (map translate-codon codons)]
    (take-while #(not= "STOP" %) translations)))
