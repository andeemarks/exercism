// Package luhn implements the exercism.io Luhn number solution.
package luhn

import (
	"strconv"
	"strings"
)

func isSecondDigit(idx int) bool { return idx%2 == 1 }

func sumDigits(number string) (sum int) {
	for reverseIdx, forwardIdx := len(number)-1, 0; reverseIdx >= 0; reverseIdx, forwardIdx = reverseIdx-1, forwardIdx+1 {
		var digit = int(number[reverseIdx] - '0')

		if isSecondDigit(forwardIdx) {
			var doubledDigit = digit * 2
			if doubledDigit > 9 {
				sum += doubledDigit - 9
			} else {
				sum += doubledDigit
			}
		} else {
			sum += digit
		}
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
