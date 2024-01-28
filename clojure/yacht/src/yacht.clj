(ns yacht)

(defn- n-for-each-n [die-rolls n] (* n (count (filter #(= n %) die-rolls))))
(defn- face-occurring-n [die-rolls n] (first (map first (filter (comp #{n} last) (frequencies die-rolls)))))
(defn- run? [die-rolls from to] (= (vec (range from (inc to))) (sort die-rolls)))
(defn- points-for [pred points] (if pred points 0))
(def numeric-categories {"ones" 1, "twos" 2, "threes" 3, "fours" 4, "fives" 5, "sixes" 6})

(defn score [die-rolls category]
  (condp = category
    "yacht" (points-for (= 1 (count (distinct die-rolls))) 50)
    "choice" (reduce + die-rolls)
    "big straight" (points-for (run? die-rolls 2 6) 30)
    "little straight" (points-for (run? die-rolls 1 5) 30)
    "full house" (points-for (= '(2 3) (sort (vals (frequencies die-rolls))))
                             (reduce + die-rolls))
    "four of a kind" (* 4
                        (or
                         (or (face-occurring-n die-rolls 4)
                             (face-occurring-n die-rolls 5))
                         0))
    (n-for-each-n
     die-rolls
     (get numeric-categories category))))
