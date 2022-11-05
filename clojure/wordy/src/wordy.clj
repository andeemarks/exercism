(ns wordy)

(defn- operand [q i] (Integer/parseInt (nth q i)))

(defn- calculate
  ([q]
   (calculate
    (operand q 1)
    (nth q 2)
    (operand q 3)))
  ([o1 operator o2]
   (case operator
     "plus" (+ o1 o2)
     "minus" (- o1 o2)
     "divided by" (/ o1 o2)
     "multiplied by" (* o1 o2))))

(defn evaluate [q]
  (let [common-op-re "(plus|minus|divided by|multiplied by) (-*\\d+)"
        single-op-q (re-find (re-pattern (str "What is (-*\\d+) " common-op-re "\\?")) q)
        double-op-q (re-find (re-pattern (str "What is (-*\\d+) " common-op-re " " common-op-re "\\?")) q)]
    (cond
      (not (nil? single-op-q)) (calculate single-op-q)
      (not (nil? double-op-q)) (-> (calculate double-op-q)
                                   (calculate
                                    (nth double-op-q 4)
                                    (operand double-op-q 5)))
      :else (throw (IllegalArgumentException.)))))
