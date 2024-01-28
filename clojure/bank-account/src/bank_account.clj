(ns bank-account)

(def account (atom {:status :open, :balance 0}))

(defn open-account []
  ;; (println @account)
  @account)

(defn close-account [_]
  (reset! account {:status :open, :balance 0}))

(defn get-balance [old-account]
  (println (str "account: " @account))
  (println (str "status: " (get @account :status)))
  (if (= :open (get @account :status))
    (get @account :balance)
    nil))

(defn update-balance [old-account amount]
  (swap! account (assoc old-account :balance amount)))
