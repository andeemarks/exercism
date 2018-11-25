// Package scrabble implements the exercism.io Scrabble solution.
package scrabble

import (
	"unicode"
)

// Score returns the correct scrabble score for the input
func Score(letters string) (score int) {
	for _, char := range letters {
		score += scoreForLetter(char)
	}

	return score
}

func scoreForLetter(letter rune) (score int) {
	switch unicode.ToUpper(letter) {
	case 'D', 'G':
		return 2
	case 'B', 'C', 'M', 'P':
		return 3
	case 'F', 'H', 'V', 'W', 'Y':
		return 4
	case 'K':
		return 5
	case 'J', 'X':
		return 8
	case 'Q', 'Z':
		return 10
	}
	return 1
}
