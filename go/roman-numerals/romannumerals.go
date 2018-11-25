// Package romannumerals implements the exercism.io Roman Numerals solution.
package romannumerals

import (
	"errors"
	"strings"
)

func substituteRomanForArabic(arabic int, ceiling int, currentRoman []string, substitution string) ([]string, int) {

	var numberOfReductions = (arabic / ceiling)
	for i := 0; i < numberOfReductions; i++ {
		currentRoman = append(currentRoman, substitution)
		arabic = arabic - ceiling
	}

	return currentRoman, arabic
}

// ToRomanNumeral converts arabic numeral into roman representation, returning the result and an error flag
func ToRomanNumeral(arabic int) (romanNumeral string, err error) {
	if arabic <= 0 || arabic > 3000 {
		return "", errors.New("")
	}

	var romanLetter []string

	romanLetter, arabic = substituteRomanForArabic(arabic, 1000, romanLetter, "M")
	romanLetter, arabic = substituteRomanForArabic(arabic, 900, romanLetter, "CM")
	romanLetter, arabic = substituteRomanForArabic(arabic, 500, romanLetter, "D")
	romanLetter, arabic = substituteRomanForArabic(arabic, 400, romanLetter, "CD")
	romanLetter, arabic = substituteRomanForArabic(arabic, 100, romanLetter, "C")
	romanLetter, arabic = substituteRomanForArabic(arabic, 90, romanLetter, "XC")
	romanLetter, arabic = substituteRomanForArabic(arabic, 50, romanLetter, "L")
	romanLetter, arabic = substituteRomanForArabic(arabic, 40, romanLetter, "XL")
	romanLetter, arabic = substituteRomanForArabic(arabic, 10, romanLetter, "X")
	romanLetter, arabic = substituteRomanForArabic(arabic, 9, romanLetter, "IX")
	romanLetter, arabic = substituteRomanForArabic(arabic, 5, romanLetter, "V")
	romanLetter, arabic = substituteRomanForArabic(arabic, 4, romanLetter, "IV")
	romanLetter, arabic = substituteRomanForArabic(arabic, 1, romanLetter, "I")

	romanNumeral = strings.Join(romanLetter, "")

	return
}
