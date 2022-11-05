(ns octal)

(defn- base-8-to-base-10 [position, digit]
  (* (Character/digit digit 10) (Math/pow 8 position)))

(defn to-decimal [octal]
  (if (not (nil? (re-find #"[89A-Za-z]+" octal)))
    0
    (int (apply +
                (map-indexed
                 base-8-to-base-10
                 (reverse octal))))))