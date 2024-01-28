(ns pig-latin
  (:require [clojure.string :as s]))

(def vowel-sounds ["a" "e" "i" "o" "u" "xr" "xt" "yt"])
(def consonant-sounds ["b" "c" "d" "f" "g" "h" "j" "p" "k" "y" "x" "q" "r" "s" "ch" "qu" "th" "thr" "sch" "rh"])

(defn- find-consonant-prefix [word]
  (->> consonant-sounds
       (filter #(s/starts-with? word %))
       (sort)
       (last)))

;; Source: https://stackoverflow.com/questions/55489706/finding-index-of-vowels-in-a-string-clojure
(defn- index-of-first-vowel [word]
  (let [m (re-matcher #"[aeiou]" word)]
    (when (re-find m) (.start m))))

(defn- consonant-prefix [word]
  (try
    (< 0 (index-of-first-vowel word))
    (catch NullPointerException _ true)))

(defn- vowel-prefix? [word]
  (seq (filter #(s/starts-with? word %) vowel-sounds)))

(defn- add-suffix [word] (str word "ay"))

(defn- move-prefix-to-end
  ([word]
   (->> word
        (index-of-first-vowel)
        (split-at word)
        (first)
        (move-prefix-to-end word)))
  ([word prefix]
   (->> word
        (split-at (count prefix))
        (reverse)
        (flatten)
        (apply str))))

(defn- translate-word-with-vowel-prefix [word]
  (add-suffix word))

(defn- translate-word-with-consonant-prefix [word]
  (->> word
       (find-consonant-prefix)
       (move-prefix-to-end word)
       (add-suffix)))

(defn- two-letter-word-with-y-suffix? [word]
  (and (= 2 (count word))
       (= \y (last word))))

(defn- consonant-sound-with-qu-suffix? [word]
  (and (consonant-prefix word)
       (s/starts-with? word (str (find-consonant-prefix word) "qu"))))

(defn- translate-word-with-consonant-qu-prefix [word]
  (add-suffix (move-prefix-to-end word (str (find-consonant-prefix word) "qu"))))

(defn- translate-word [word]
  (cond
    (consonant-sound-with-qu-suffix? word) (translate-word-with-consonant-qu-prefix word)
    (two-letter-word-with-y-suffix? word) (translate-word-with-vowel-prefix (apply str (reverse word)))
    (vowel-prefix? word) (translate-word-with-vowel-prefix word)
    (consonant-prefix word) (translate-word-with-consonant-prefix word)))

(defn translate [phrase]
  (s/join " "
          (map #(translate-word %)
               (s/split phrase #" "))))
