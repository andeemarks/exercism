(ns anagram
  (:require [clojure.string :as str]))

(defn- sorted-letters [word]
  (-> word
      (str/lower-case)
      (str/split #"")
      (sort)))

(defn- has-same-letters? [word1 word2]
  (= (sorted-letters word1) (sorted-letters word2)))

(defn- is-different-word? [word1 word2]
  (not= (str/lower-case word1)
        (str/lower-case word2)))

(defn- is-anagram-of? [word1 word2]
  (and (is-different-word? word1 word2)
       (has-same-letters? word1 word2)))

(defn anagrams-for [word prospect-list]
  (filter #(is-anagram-of? word %) prospect-list))
