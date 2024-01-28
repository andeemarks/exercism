(ns sublist)

(defn- prefixed-by? [list1 list2]
  (let [list2-length-list1 (vec (take (count list2) list1))]
    (when (>= (count list2-length-list1) (count list2))
      (= list2-length-list1 list2))))

(defn- is-sublist? [list1 list2]
  (when (>= (count list1) (count list2))
    (if (prefixed-by? list1 list2)
      true
      (is-sublist? (vec (drop 1 list1)) list2))))

(defn classify [list1 list2]
  (cond
    (= list1 list2) :equal
    (is-sublist? list1 list2) :superlist
    (is-sublist? list2 list1) :sublist
    :else :unequal))
