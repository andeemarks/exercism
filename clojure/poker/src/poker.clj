(ns poker
  (:require [clojure.string :refer [split join index-of]]))

(def ordered-ranks "AKQJ10987654321")

(defn- compare-ranks-only
  [card-1 card-2]
  (println "compare-ranks-only")
  (let [rank-1 (join (drop-last card-1))
        rank-2 (join (drop-last card-2))
        _ (println rank-1)
        _ (println rank-2)]
    (<
     (index-of ordered-ranks (if (empty? rank-1) (last ordered-ranks) rank-1))
     (index-of ordered-ranks (if (empty? rank-2) (last ordered-ranks) rank-2)))))

(defn- pairs-only [h]
  (flatten
   (filter #(= 2 (count %))
           (vals
            (group-by
             first
             (clojure.string/split h #" "))))))

(defn- compare-ranks [card-1 card-2]
  (println "Comparing based on ranks")
  (println card-1)
  (println card-2)
  (compare-ranks-only card-1 card-2))

(defn- compare-pairs [card-1 card-2]
  (println "Comparing based on pairs")
  (println card-1)
  (println card-2)
  (compare-ranks-only card-1 card-2))

(defn- sort-by-best-hand [hand-1 hand-2]
  (let [hand-1-pairs (pairs-only hand-1)
        hand-1-by-pairs (sort-by identity compare-ranks-only hand-1-pairs)
        hand-1-by-ranks (sort-by identity compare-ranks-only (split hand-1 #" "))
        ;; _ (println hand-1-by-pairs)
        ;; _ (println (first hand-1-by-ranks))
        hand-2-pairs (pairs-only hand-2)
        hand-2-by-pairs (sort-by identity compare-ranks-only hand-2-pairs)
        hand-2-by-ranks (sort-by identity compare-ranks-only (split hand-2 #" "))
        ;; _ (println hand-2-by-pairs)
        ;; _ (println (first hand-1-by-ranks)) _ (println (first hand-1-by-ranks))
        ]
    (if (and (empty? hand-1-pairs) (empty? hand-2-pairs))
      (compare-ranks (first hand-1-by-ranks) (first hand-2-by-ranks))
      (compare-pairs (first hand-1-by-pairs) (first hand-2-by-pairs)))))

(defn best-hands [hands]
  (let [sorted-hands (sort-by identity sort-by-best-hand hands)
        ;; _ (println sorted-hands)
        ]
    (vector (last sorted-hands))))
