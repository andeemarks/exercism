// Package diffsquares implements the exercism.io Difference of Squares solution
package diffsquares

import "math"

// See http://mathcentral.uregina.ca/QQ/database/QQ.02.06/jo1.html
func guassianSum(limit int) (sum int) {
	return (limit / 2) * (1 + limit)
}

// SquareOfSum calculates the square of the sum of the first limit natural numbers
func SquareOfSum(limit int) (sum int) {
	var remainder = limit % 2
	sum = guassianSum(limit-remainder) + (limit * remainder)

	return sum * sum
}

// See https://en.wikipedia.org/wiki/Square_pyramidal_number
func faulhaberSum(limit float64) (sum int) {
	return int((2*math.Pow(limit, 3) + 3*math.Pow(limit, 2) + limit) / 6)
}

// SumOfSquares calculates the sum of the square of the first limit natural numbers,
func SumOfSquares(limit int) (sum int) {
	return faulhaberSum(float64(limit))
}

// Difference can calculate the difference between the sum of the square of the first limit natural numbers,
// and the square of the sum of the first limit natural numbers
func Difference(limit int) int {
	return SquareOfSum(limit) - SumOfSquares(limit)
}
