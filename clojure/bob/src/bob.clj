(ns bob)

(defn- question? [s]
  (clojure.string/ends-with? s "?"))

(defn- isolate-chars [s]
  (apply str (filter #(Character/isLetter %) s)))

(defn- shouted? [s]
  (let [pure-s (isolate-chars s)]
    (and
     (< 0 (count pure-s))
     (= pure-s (clojure.string/upper-case pure-s)))))

(defn- silence? [s]
  (= 0 (count (clojure.string/trim s))))

(defn- shouted-question? [s]
  (and (shouted? s) (question? s)))

(defn response-for [s]
  (cond
    (shouted-question? s) "Calm down, I know what I'm doing!"
    (question? s) "Sure."
    (silence? s) "Fine. Be that way!"
    (shouted? s) "Whoa, chill out!"
    :else "Whatever."))
