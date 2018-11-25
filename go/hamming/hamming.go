// Package hamming provides capability to calculate the Hamming distance between two strings.
package hamming

import (
	"fmt"
)

func checkCharacter(a string, b string, pos int, distance int) int {
	if pos >= len(a) {
		return distance
	}

	if a[pos] != b[pos] {
		distance++
	}

	return checkCharacter(a, b, pos+1, distance)

}

// Distance calculates the Hamming distance between a and b, returning the distance and any errors encounterded due to bad input
func Distance(a, b string) (int, error) {
	if len(a) != len(b) {
		return -1, fmt.Errorf("unexpected length mismatch in inputs %s and %s", a, b)
	}

	return checkCharacter(a, b, 0, 0), nil
}
