(ns robot-simulator)

;; a map of current bearing to relative left and right bearings,
;; as well as the anonymous function to update the coordinates when moving.
(def bearings
  {:north {\L :west \R :east \A (fn [position] (update position :y inc))}
   :west {\L :south \R :north \A (fn [position] (update position :x dec))}
   :south {\L :east \R :west \A (fn [position] (update position :y dec))}
   :east {\L :north \R :south \A (fn [position] (update position :x inc))}})

(defn robot
  [position bearing]
  {:bearing bearing :coordinates position})

(defn- advance-position [robot]
  (let [advancer (get-in bearings [(get robot :bearing) \A])
        new-position (advancer (get robot :coordinates))]
    (assoc
     robot
     :coordinates
     new-position)))

(defn- rotate [robot direction]
  (let [new-bearing (get-in bearings [(get robot :bearing) direction])]
    (assoc                                       ; assoc updates a key-value in a map
     robot
     :bearing
     new-bearing)))

(defn simulate-single-instruction
  [instruction robot]
  (if (= \A instruction)                         ; \A = the character "A"
    (advance-position robot)                     ; true clause (instruction = "A")
    (rotate robot instruction)))                 ; false clause (instruction != "A")

(defn simulate                                   ; named function definition
  [instruction-list robot]                       ; arguments 
  (if (empty? instruction-list)                  ; function returns result of "if"...
    robot
    (let [updated-robot                          ; local variable definition
          (simulate-single-instruction           ; you'll see this function soon
           (first instruction-list)              ; first element (character) from instruction string
           robot)]
      (simulate                                  ; recursive call
       (rest instruction-list)                   ; everything but the first element
       updated-robot))))
