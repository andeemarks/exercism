(ns queen-attack
  (:require [clojure.string :refer [join trim replace-first split]]))

(defn- to-row [squares]
  (str (join " " squares) "\n"))

(defn- to-board [squares]
  (apply str (map #(to-row %) (partition 8 squares))))

(defn- sort-pieces [[white-row white-column] [black-row black-column]]
  (let [white-pos (+ (* white-row 8) white-column)
        black-pos (+ (* black-row 8) black-column)]
    (if (> white-pos black-pos)
      {:last {:pos (- 63 white-pos) :piece "W"} :first {:pos black-pos :piece "B"}}
      {:first {:pos white-pos :piece "W"} :last {:pos (- 63 black-pos) :piece "B"}})))

(defn- place-first-queen [squares regex piece]
  (replace-first squares regex (str "$1" (:piece piece))))

(defn- place-last-queen [squares regex piece]
  (-> squares
      (clojure.string/reverse) ;; reverse before last regex
      (replace-first regex (str "$1" (:piece piece)))
      (clojure.string/reverse)))

(defn- populate-board [w b]
  (let [pieces (sort-pieces w b)
        first-regex (re-pattern (str "(_{" (:pos (:first pieces)) "})(_)"))
        last-regex (re-pattern (str "(_{" (:pos (:last pieces)) "})(_)"))
        squares (-> (join (repeat 64 "_"))
                    (place-first-queen first-regex (:first pieces))
                    (place-last-queen last-regex (:last pieces))
                    (split #""))]
    (to-board squares)))

(defn board-string [{:keys [w b]}]
  (let [empty-board (str (join "\n" (repeat 8 "_ _ _ _ _ _ _ _")) "\n")]
    (if (nil? (or w b))
      empty-board
      (populate-board w b))))

(defn can-attack [{:keys [w b]}]
  (let [[white-row white-column] w
        [black-row black-column] b
        row-diff (Math/abs (- white-row black-row))
        column-diff (Math/abs (- white-column black-column))]
    (or
     (= white-row black-row)
     (= white-column black-column)
     (= row-diff column-diff))))
