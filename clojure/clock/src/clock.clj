(ns clock)

(defn clock->string [clock] (format "%02d:%02d" (:hours clock) (:minutes clock)))

(defn- norm-minutes [minutes] (mod minutes 60))
(defn- norm-hours [minutes] (mod minutes 24))

(defn- roll-minutes [minutes]
  (cond
    (< minutes 0) (- (quot minutes 60) 1)
    (>= minutes 0) (quot minutes 60)))

(defn clock [hours minutes]
  {:hours (norm-hours (+ hours (roll-minutes minutes)))
   :minutes (norm-minutes minutes)})

(defn add-time [{:keys [hours minutes]} delta]
  (clock hours (+ minutes delta))) 
