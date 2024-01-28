(ns pangram
  (:require [clojure.string :as s]))

(defn pangram? [sentence]
  (let [letters-only (filter #(Character/isLetter %)
                             (s/lower-case sentence))]
    (= 26
       (count (set letters-only)))))
