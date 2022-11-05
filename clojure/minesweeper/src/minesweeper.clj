(ns minesweeper
  (:require [clojure.string :as str]))

(def line-separator (System/getProperty "line.separator"))

(defn- inc-mine-count [count] (inc (Integer/parseInt (str (first count)))))

(defn- find-mine [i row]
  (cond
    (re-find #"[\d]\*[\d]" row) (str/replace row #"[\d]\*[\d]" #(str (inc-mine-count %1) "*" (inc-mine-count %2)))
    (re-find #"\*[\d]" row) (str/replace row #"\*[\d]" #(str "*" (inc-mine-count %1)))
    (re-find #"[\d]\*" row) (str/replace row #"[\d]\*" #(str (inc-mine-count %1) "*"))
    (re-find #"\* " row) (str/replace row #"\* " "*1")
    (re-find #" \*" row) (str/replace row #" \*" "1*")
    :default row))

(defn draw [board]
  (let [rows (str/split board (re-pattern line-separator))
        mines (map-indexed find-mine rows)
        _ (println mines)]
    (str/join line-separator mines)))
