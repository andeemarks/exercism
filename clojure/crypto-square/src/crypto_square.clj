(ns crypto-square
  (:require [clojure.string :as str]))

(defn normalize-plaintext [plaintext] (str/lower-case (str/replace plaintext #"[^\w]" "")))

(defn square-size [text] (->> text
                              (count)
                              (Math/sqrt)
                              (Math/ceil)
                              (int)))

(defn plaintext-segments [plaintext]
  (let [text (normalize-plaintext plaintext)
        length (square-size text)]
    (map str/join (partition length length "" (str/split text #"")))))

(defn- pad-to [s length] (format (str "%-" length "s") s))

(defn equalise-segment-lengths [segments required-length]
  (map #(pad-to % required-length) segments))

(defn ciphertext [plaintext]
  (let [column-length (square-size (normalize-plaintext plaintext))
        segments (plaintext-segments plaintext)
        segments-eq (equalise-segment-lengths segments column-length)
        columns (apply interleave segments-eq)]
    (str/replace (str/join columns) #"[ ]+" "")))

(defn- format-ciphertext [ciphertext]
  (->> ciphertext
       (map #(str/trim (str/join %)))
       (str/join " ")))

(defn normalize-ciphertext [plaintext]
  (let [row-length (count (plaintext-segments plaintext))
        column-length (square-size (normalize-plaintext plaintext))
        ciphertext (ciphertext plaintext)
        maximum-length (* row-length column-length)
        length-shortfall (- maximum-length (count ciphertext))
        full-segments-length (* row-length (- column-length length-shortfall))
        full-segments (->>  ciphertext
                            (take full-segments-length)
                            (partition row-length))
        short-segments (->> ciphertext
                            (drop full-segments-length)
                            (partition (dec row-length)))]
    (format-ciphertext (concat full-segments short-segments))))
