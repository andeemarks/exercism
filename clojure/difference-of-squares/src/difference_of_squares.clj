(ns difference-of-squares)

(defn sum-of-squares [n]
  (apply + (map #(* % %) (range 0 (+ 1 n)))))

(defn square-of-sum [n]
  (int (Math/pow (apply + (range 0 (+ 1 n))) 2)))

(defn difference [n]
  (-  (square-of-sum n) (sum-of-squares n)))
