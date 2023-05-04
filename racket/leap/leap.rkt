#lang racket

(provide leap-year?)

(define (leap-year? year)
  (cond
    [(= 0 (modulo year 400)) #t]
    [(= 0 (modulo year 100)) #f]
    [(= 0 (modulo year 4)) #t]
    [else #f]))
