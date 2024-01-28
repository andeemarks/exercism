(ns isogram
  (:require [clojure.string :as s]))

(defn isogram? [phrase]
  (let [letters (filter #(Character/isLetter %) (s/lower-case phrase))
        unique-letters (set letters)]
    (= (count letters) (count unique-letters))))
