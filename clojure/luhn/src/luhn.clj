(ns luhn)

(defn- double-if-2nd [i digit]
  (if (= 1 (mod i 2))
    (let [doubled (* 2 digit)]
      (if (> doubled 9) (- doubled 9) doubled))
    digit))

(defn valid? [n]
  (let [n-digits (clojure.string/replace n #"[^\d+]" "")
        digits (map #(Integer/parseInt %) (clojure.string/split n-digits #""))
        doubled-digits (map-indexed double-if-2nd (reverse digits))
        sum (apply + doubled-digits)]
    (and
     (nil? (re-find #"[^\d ]" n)) ;; check for invalid chars
     (> (count digits) 1)
     (= 0 (mod sum 10)))))

