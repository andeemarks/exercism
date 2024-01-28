(ns raindrops)

(defn- wordy [number factor word]
  (if (zero? (rem number factor))
    word
    ""))

(defn- plingy [number] (wordy number 3 "Pling"))
(defn- plangy [number] (wordy number 5 "Plang"))
(defn- plongy [number] (wordy number 7 "Plong"))

(defn convert [number]
  (let [converted-number
        (clojure.string/join ""
                             [(plingy number) (plangy number) (plongy number)])]
    (if (empty? converted-number)
      (str number)
      converted-number)))

