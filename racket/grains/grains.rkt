#lang racket

(provide square total)


(define (square a-square)
  (expt 2 (- a-square 1)))

(define (total)
  (foldl 
    + 
    0 
    (map 
      (lambda (a-square) (square a-square)) 
      (range 1 65))))
