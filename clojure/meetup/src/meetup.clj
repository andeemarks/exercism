(ns meetup
  (:import java.util.Calendar)
  (:require [clojure.set :ref all]))

(defn- enumerate-month [month today date month-length]
  (if (> date month-length)
    month
    (enumerate-month
     (merge month (hash-map date (.get today Calendar/DAY_OF_WEEK)))
     (doto today (.roll Calendar/DATE 1))
     (+ 1 date)
     month-length)))

(defn- find-date-of-day-in-week [week day]
  (let [day-of-week (get {:sunday 1 :monday 2 :tuesday 3 :wednesday 4 :thursday 5 :friday 6 :saturday 7} day)]
    (get week day-of-week)))

(defn- find-week-from [month first-date]
  (clojure.set/map-invert (select-keys month (vec (range first-date (+ first-date 7))))))

(defn meetup [month year day qualifier]
  (let [start (doto (Calendar/getInstance)
                (.set Calendar/MONTH (- month 1))
                (.set Calendar/YEAR year)
                (.set Calendar/DATE 1))
        month-length (.getActualMaximum start Calendar/DATE)
        full-month (enumerate-month '{} start 1 month-length)
        first-day-of-week (get {:first 1 :second 8 :third 15 :fourth 22 :teenth 13 :last (- month-length 6)} qualifier)
        date (find-date-of-day-in-week (find-week-from full-month first-day-of-week) day)]
    (vector year month date)))