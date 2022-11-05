(ns series)

(defn- slice [slices source length]
  (if (> length (count source))
    slices
    (slice
     (conj slices (subs source 0 length))
     (subs source 1)
     length)))

(defn slices
  [source length]
  (if (= 0 length)
    '[""]
    (slice '[] source length)))
