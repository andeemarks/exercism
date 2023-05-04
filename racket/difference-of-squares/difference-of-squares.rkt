#lang racket

(provide sum-of-squares square-of-sum difference)

(define (sum-of-squares number)
  (foldl 
    + 
    0 
    (map 
      (lambda (number) (* number number)) 
      (range (+ 1 number)))))

(define (square-of-sum number)
  (expt 
    (foldl + 0 (range (+ 1 number))) 
    2))

(define (difference number)
  (- 
    (square-of-sum number) 
    (sum-of-squares number)))
