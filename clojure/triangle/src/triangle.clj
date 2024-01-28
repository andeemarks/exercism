(ns triangle)

(defn- is-valid? [sides]
  (let [increasing-sides (sort sides)]
    (< (last increasing-sides)
       (+ (first increasing-sides)
          (second increasing-sides)))))

(defn- unique-side-count [sides]
  (count (set sides)))

(defn equilateral? [& sides]
  (and (is-valid? sides)
       (= 1 (unique-side-count sides))))

(defn isosceles? [& sides]
  (and (is-valid? sides)
       (>= 2 (unique-side-count sides))))

(defn scalene? [& sides]
  (and (is-valid? sides)
       (= 3 (unique-side-count sides))))
