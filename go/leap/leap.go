// Package leap should have a package comment that summarizes what it's about.
// https://golang.org/doc/effective_go.html#commentary
package leap

import "math"

// IsLeapYear returns true if year is a leap year, false otherwise
func IsLeapYear(year int) bool {
	var divisibleBy400 = math.Remainder(float64(year), 400) == 0
	var divisibleBy100 = math.Remainder(float64(year), 100) == 0
	var divisibleBy4 = math.Remainder(float64(year), 4) == 0

	return divisibleBy400 || (divisibleBy4 && !divisibleBy100)
}
