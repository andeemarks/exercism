(ns armstrong-numbers)

(defn armstrong? [num] 
  (let [digits (map #(Character/digit % 10) (str num))
        powers (map #(Math/pow % (count digits)) digits)]
      (== num (reduce + powers)) ))