(ns card-games)

(defn- next-round-for [round] [round (+ round 1) (+ round 2)])

(defn rounds
  "Takes the current round number and returns 
   a `list` with that round and the _next two_."
  [n]
  (next-round-for n))

(defn concat-rounds
  "Takes two lists and returns a single `list` 
   consisting of all the rounds in the first `list`, 
   followed by all the rounds in the second `list`"
  [l1 l2]
  (concat l1 l2))

(defn contains-round?
  "Takes a list of rounds played and a round number.
   Returns `true` if the round is in the list, `false` if not."
  [l n]
  (not (nil? (some #(= n %) l))))

(defn card-average
  "Returns the average value of a hand"
  [hand]
  (float
   (/
    (reduce + hand)
    (count hand))))

(defn approx-average?
  "Returns `true` if average is equal to either one of:
  - Take the average of the _first_ and _last_ number in the hand.
  - Using the median (middle card) of the hand."
  [hand]
  (let [average (card-average hand)
        first-and-last-average (card-average (concat-rounds (list (first hand)) (list (last hand))))
        median (nth hand (quot (count hand) 2))]
    (or
     (== average first-and-last-average)
     (== average median))))

(defn average-even-odd?
  "Returns true if the average of the cards at even indexes 
   is the same as the average of the cards at odd indexes."
  [hand]
  (let [even-average (card-average (keep-indexed #(if (odd? %1) %2) hand))
        odd-average (card-average (keep-indexed #(if (even? %1) %2) hand))]
    (== even-average odd-average)))

(defn- jack? [card]
  (= 11 card))

(defn maybe-double-last
  "If the last card is a Jack (11), doubles its value
   before returning the hand."
  [hand]
  (let [last-card (last hand)
        scale (if (jack? last-card) 2 1)]
    (concat (drop-last hand) (list (* scale last-card)))))
