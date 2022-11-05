(ns allergies)

(def items {:eggs 1
            :peanuts 2
            :shellfish 4
            :strawberries 8
            :tomatoes 16
            :chocolate 32
            :pollen 64
            :cats 128})

(defn- item-not-greater-than [value] (last (filter #(>= value (second %)) items)))

(defn- allergies-matching [score]
  (loop [allergies '[]
         value score]
    (if (<= value 0)
      allergies
      (let [allergy (item-not-greater-than value)
            reduced-score (- value (second allergy))]
        (recur (cons (first allergy) allergies) reduced-score)))))

(defn allergies [score]
  (dedupe (allergies-matching score)))

(defn allergic-to? [score item]
  (<= (get items item) score))
