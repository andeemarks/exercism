// Package triangle contains code to determine what type of triangle is specified by a number of side lengths
package triangle

import (
	"math"
	"sort"
)

// Kind enumerates the possible responses from KindFromSides
type Kind int

const (
	// NaT means "not a triangle"
	NaT = iota
	// Equ means equilateral
	Equ
	// Iso means isosceles
	Iso
	// Sca means scalene
	Sca
)

func allSidesEqual(a, b, c float64) bool      { return a == b && b == c }
func negativeSideLength(a, b, c float64) bool { return a <= 0 || b <= 0 || c <= 0 }
func invalidLength(l float64) bool            { return math.IsNaN(l) || math.IsInf(l, 0) }

func invalidSideLength(a, b, c float64) bool {
	return invalidLength(a) || invalidLength(b) || invalidLength(c)
}

func allSidesUnequal(a, b, c float64) bool { return a != b && b != c && a != c }
func sidesDontFormTriangle(a, b, c float64) bool {
	sortedSides := []float64{a, b, c}
	sort.Float64s(sortedSides)

	return sortedSides[2] > sortedSides[0]+sortedSides[1]
}

// KindFromSides returns a Kind specifying what type of triangle is described by a, b, c
func KindFromSides(a, b, c float64) Kind {
	if invalidSideLength(a, b, c) || negativeSideLength(a, b, c) || sidesDontFormTriangle(a, b, c) {
		return NaT
	}

	if allSidesEqual(a, b, c) {
		return Equ
	}

	if allSidesUnequal(a, b, c) {
		return Sca
	}

	return Iso
}
