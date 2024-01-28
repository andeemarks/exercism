(ns space-age)

(defn- base [seconds]
  (/
   seconds
   60 ; seconds->minutes
   60 ; minutes->hours
   24 ; hours->days
   365.25 ; days->years
   ))

(defn on-earth [seconds]
  (/ (base seconds) 1))

(defn on-mercury [seconds]
  (/ (base seconds) 0.2408467))

(defn on-venus [seconds]
  (/ (base seconds) 0.61519726))

(defn on-mars [seconds]
  (/ (base seconds) 1.8808158))

(defn on-jupiter [seconds]
  (/ (base seconds) 11.862615))

(defn on-saturn [seconds]
  (/ (base seconds) 29.447498))

(defn on-uranus [seconds]
  (/ (base seconds) 84.016846))

(defn on-neptune [seconds]
  (/ (base seconds) 164.79132))
