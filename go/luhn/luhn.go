// Package luhn implements the exercism.io Luhn number solution.
package luhn

import (
	"strconv"
	"strings"
)

func findDigitToSum(digit int, digitPos int) int {
	if digitPos%2 == 1 {
		var doubledDigit = digit * 2
		if doubledDigit > 9 {
			return doubledDigit - 9
		}

		return doubledDigit
	}

	return digit
}

func sumDigits(number string) (sum int) {
	var forwardIdx int
	for i := len(number) - 1; i >= 0; i = i - 1 {
		var digit = int(number[i] - '0')

		sum += findDigitToSum(digit, forwardIdx)

		forwardIdx++
	}

	return sum
}

// Valid returns true if number is a valid luhn number, false otherwise
func Valid(number string) bool {
	var cleanNumber = strings.Replace(number, " ", "", -1)
	var _, err = strconv.ParseInt(cleanNumber, 10, 64)

	if len(cleanNumber) <= 1 || err != nil {
		return false
	}

	return sumDigits(cleanNumber)%10 == 0
}
