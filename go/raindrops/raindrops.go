// Package raindrops provides the solution to the Exercism raindrops exercise.
package raindrops

import "strconv"

// Convert returns a string containing an Raindrop-ese translation of the provided number
func Convert(number int) (conversion string) {
	if number%3 == 0 {
		conversion += "Pling"
	}
	if number%5 == 0 {
		conversion += "Plang"
	}
	if number%7 == 0 {
		conversion += "Plong"
	}

	if conversion == "" {
		conversion = strconv.Itoa(number)
	}

	return
}
