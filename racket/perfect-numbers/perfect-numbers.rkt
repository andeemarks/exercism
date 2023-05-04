#lang racket

(require math/number-theory)

(provide classify)

(define (classify number)
  (let* (
    [factors (drop-right (divisors number) 1)]
    [sum-of-factors (for/sum ([i factors]) i)])
    (cond
      [(< number sum-of-factors) 'abundant]
      [(> number sum-of-factors) 'deficient]
      [else 'perfect])))
