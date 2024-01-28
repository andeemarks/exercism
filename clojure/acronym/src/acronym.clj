(ns acronym
  (:require [clojure.string :as str]))

(defn- find-acronym-letters [word]
  (let [upper-case-letters (str/join "" (filter #(Character/isUpperCase %) word))
        capital-first-letter (str/capitalize (get word 0))
        word-is-acronym? (= word (str/upper-case word))]
    (if (empty? upper-case-letters)
      capital-first-letter
      (if word-is-acronym?
        capital-first-letter
        upper-case-letters))))

(defn- compose-acronym [words]
  (str/join ""
            (map #(find-acronym-letters %) words)))

(defn acronym
  "Converts phrase to its acronym."
  [phrase]
  (if (empty? phrase)
    ""
    (compose-acronym (str/split phrase #"[\- ]"))))
