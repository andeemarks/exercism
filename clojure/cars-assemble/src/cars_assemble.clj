(ns cars-assemble)

(defn- base-production-rate [speed] (* speed 221.0))

(defn production-rate
  "Returns the assembly line's production rate per hour,
   taking into account its success rate"
  [speed]
  (let [base-rate (base-production-rate speed)]
    (cond (<= speed 4) base-rate
          (<= speed 8) (* base-rate 0.9)
          (<= speed 9) (* base-rate 0.8)
          (<= speed 10) (* base-rate 0.77))))

(defn working-items
  "Calculates how many working cars are produced per minute"
  [speed]
  (int
   (/
    (production-rate speed)
    60)))
