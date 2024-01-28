(ns squeaky-clean
  (:require [clojure.string :as str]))

(defn clean
  "TODO: add docstring"
  [s]
  (-> s
      (str/replace " " "_")
      (str/replace #"[\u0000-\u001F]" "CTRL")
      (str/replace #"\-(\p{L})" (fn [[_ letter]] (str/upper-case letter)))
      (str/replace #"[\u007F-\u009F]" "CTRL")
      (str/replace #"[^_\p{L}]" "")
      (str/replace #"[\p{IsGreek}&&\p{IsLowercase}]" ""))) ; from https://exercism.org/tracks/clojure/exercises/squeaky-clean/solutions/menketechnologies
