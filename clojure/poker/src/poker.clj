(ns poker
  (:require [clojure.string :refer [split join]]))

(def ^:const base-scores {"1" 1 "2" 2 "3" 3 "4" 4 "5" 5 "6" 6 "7" 7 "8" 8 "9" 9 "10" 10 "J" 11 "Q" 12 "K" 13 "A" 14})

(defn rank [card] {:pre [(<= 2 (count card))]} (join (drop-last card)))
(defn suit [card] {:pre [(<= 2 (count card))]} (str (last card)))
(defn score-for-rank [rank] {:pre [(contains? base-scores rank)]} (get base-scores rank))
(defn hand-to-cards [hand] {:post [(= 5 (count %))]} (split hand #" "))
(defn score-hand-ranks [hand] (->> hand
                                   hand-to-cards
                                   (map #(score-for-rank (rank %)))
                                   sort))

(def ^:const sample-aces-low-straight "2S 3S 4S 5S AS")

(defn multiples [hand multiple-size] {:pre [> 1 multiple-size]}
  (filter
   #(= multiple-size (count (val %)))
   (group-by
    identity
    (score-hand-ranks hand))))

(defn pairs [hand] (multiples hand 2))
(defn triples [hand] (multiples hand 3))
(defn quads [hand] (multiples hand 4))

(defn aces-low-straight [hand]
  (let [sorted-scores (score-hand-ranks hand)
        has-aces-low-straight (= sorted-scores (score-hand-ranks sample-aces-low-straight))]
    (if has-aces-low-straight [hand] [])))

(defn has-straight [hand]
  (let [sorted-scores (score-hand-ranks hand)
        has-5-distinct-cards (= 5 (count (set sorted-scores)))
        has-sequential-cards (= 4 (- (last sorted-scores) (first sorted-scores)))]
    (and has-5-distinct-cards has-sequential-cards)))

(defn straight [hand] (if (has-straight hand) [hand] []))

(defn has-flush [hand]
  (let [unique-suits (set (map suit (hand-to-cards hand)))]
    (= 1 (count unique-suits))))

(defn flushes [hand] (if (has-flush hand) [hand] []))

(defn straight-flushes [hand]
  (if (and (has-straight hand) (has-flush hand)) [hand] []))

(defn full-house [hand]
  (let [has-pair (seq (pairs hand))
        has-triple (seq (triples hand))]
    (if (and has-pair has-triple) [hand] [])))

(defn boost-score [score-base boost] (* (count score-base) boost))

(defn boost-score-by-secondary [secondary]
  (if (seq secondary)
    (* (Math/pow 10 5) (first (first secondary)))
    0))

(defn boost-score-if-pairs [hand] (boost-score (pairs hand) (Math/pow 10 5)))
(defn boost-score-if-triples [hand] (boost-score (triples hand) (Math/pow 10 6)))
(defn boost-score-if-aces-low-straight [hand] (boost-score (aces-low-straight hand) (Math/pow 10 7)))
(defn boost-score-if-straight [hand] (boost-score (straight hand) (Math/pow 10 8)))
(defn boost-score-if-flush [hand] (boost-score (flushes hand) (Math/pow 10 9)))

(defn boost-score-if-full-house [hand]
  (let [full-house-score (boost-score (full-house hand) (Math/pow 10 10))]
    (+ full-house-score
       (boost-score-by-secondary (triples hand)))))

(defn boost-score-if-quads [hand]
  (let [quads-score (boost-score (quads hand) (Math/pow 10 11))]
    (+ quads-score
       (boost-score-by-secondary (quads hand)))))

(defn boost-score-if-straight-flush [hand] (boost-score (straight-flushes hand) (Math/pow 10 12)))

(defn base-score [hand]
  (reduce
   +
   (map-indexed
    #(* %2 (Math/pow 10 %))
    (score-hand-ranks hand))))

(defn score-hand [hand]
  (+
   (base-score hand)
   (boost-score-if-pairs hand)
   (boost-score-if-triples hand)
   (boost-score-if-aces-low-straight hand)
   (boost-score-if-straight hand)
   (boost-score-if-flush hand)
   (boost-score-if-full-house hand)
   (boost-score-if-quads hand)
   (boost-score-if-straight-flush hand)))

(defn score-hands [hands]
  (map
   #(assoc {} :score (score-hand %) :hand %)
   hands))

(defn best-hands [hands]
  (->> hands
       score-hands
       (group-by :score)
       sort
       last
       val
       (map :hand)))