(ns binary-search)

(defn middle [list] (unchecked-divide-int (count list) 2) )

(defn search [key list from]
  (let [middle-item (nth list from)]
    (cond
      (< middle-item key) (search key (drop from list) (middle list))
      (> middle-item key) (search key (take from list) (middle list))
      (= middle-item key) from)
  ))

(defn search-for [key list]
  (let [middle-index (middle list)]
    (search key list middle-index)
  (throw (Exception. "not found")) ))
