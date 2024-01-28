(ns coordinate-transformation)

(defn translate2d
  "Returns a function making use of a closure to
   perform a repeatable 2d translation of a coordinate pair."
  [dx dy]
  (fn [x1 y1]
    [(+ dx x1) (+ dy y1)]))

(defn scale2d
  "Returns a function making use of a closure to
   perform a repeatable 2d scale of a coordinate pair."
  [sx sy]
  (fn [x1 y1]
    [(* sx x1) (* sy y1)]))


(defn compose-transform
  "Create a composition function that returns a function that 
   combines two functions to perform a repeatable transformation."
  [f g]
  (fn [x1 y1]
    (let [result (f x1 y1)]
      (g (first result) (second result)))))

(defn memoize-transform
  "Returns a function that memoizes the last result.
   If the arguments are the same as the last call,
   the memoized result is returned.
   
   Source: https://exercism.org/tracks/clojure/exercises/coordinate-transformation/solutions/Chase-Lambert
   "
  [f]
  (let [prev-args   (atom [nil nil])
        prev-result (atom nil)]
    (fn [x y]
      (if (= [x y] @prev-args)
        @prev-result
        (let [new-result (f x y)]
          (reset! prev-args [x y])
          (reset! prev-result new-result)
          new-result)))))
