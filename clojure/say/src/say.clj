(ns say
  (:require [clojure.spec.alpha :as alpha]
            [clojure.string :as str]))

(def num-words ["zero",
                "one",
                "two",
                "three",
                "four",
                "five",
                "six",
                "seven",
                "eight",
                "nine",
                "ten",
                "eleven",
                "twelve",
                "thirteen",
                "fourteen",
                "fifteen",
                "sixteen",
                "seventeen",
                "eighteen",
                "nineteen",
                "twenty"])

(def tens-words ["",
                 "",
                 "twenty",
                 "thirty",
                 "forty",
                 "fifty",
                 "sixty",
                 "seventy",
                 "eighty",
                 "ninety"])

(defn- is-num-valid? [num] (alpha/int-in-range? 0 1000000000000 num))

(defn- find-word-for-digits [num] (nth num-words num))
(defn- find-word-for-tens [num] (nth tens-words num))

(defn- clean [word]
  (-> word
      (str/replace #"\-$" "")
      (str/trim)))

(defn- str-to-int
  ([str] (Integer/parseInt str))
  ([str start end] (str-to-int (subs str start end))))

(defn- zero-pad-to-length [num length] (format (str "%0" length "d") num))

(defn- assemble-three-digit-number [num hundreds tens digits]
  (str
   (when (> num 99) (str (find-word-for-digits hundreds) " hundred "))
   (when (> num 9) (str (find-word-for-tens tens) "-"))
   (find-word-for-digits digits)))

(defn- format-number
  ([num] (format-number num ""))
  ([num unit]
   (let [digits (str-to-int num)
         full-num (zero-pad-to-length digits 3)
         formatted-number (assemble-three-digit-number
                           digits
                           (str-to-int full-num 0 1)
                           (str-to-int full-num 1 2)
                           (str-to-int full-num 2 3))]
     (if (= "zero" formatted-number)
       ""
       (format "%s %s "
               formatted-number
               unit)))))

(defn- word-for-num [num]
  (let [full-num (zero-pad-to-length num 12)]
    (if (<= num (count num-words))
      (find-word-for-digits num)
      (clean (str
              (format-number (subs full-num 0 3) "billion")
              (format-number (subs full-num 3 6) "million")
              (format-number (subs full-num 6 9) "thousand")
              (format-number (subs full-num 9 10) "hundred")
              (str (find-word-for-tens (str-to-int full-num 10 11)) "-")
              (format-number (subs full-num 11 12)))))))

(defn number [num]
  (if (is-num-valid? num)
    (word-for-num num)
    (throw (IllegalArgumentException.))))
