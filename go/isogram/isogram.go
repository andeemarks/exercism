// Package isogram implements the exercism.io isogram solution.
package isogram

import (
	"regexp"
	"unicode"
)

func charsOnlyFrom(sentence string) string {
	var onlyChars = regexp.MustCompile("[^A-Za-z+]")

	return onlyChars.ReplaceAllString(sentence, "")
}

// IsIsogram returns true if sentence has no repeating letters, false otherwise
func IsIsogram(sentence string) bool {
	var uniqueChars = make(map[rune]bool)
	var numberOfUniqueChars = 0
	var sentenceChars = charsOnlyFrom(sentence)
	for _, char := range sentenceChars {
		var lowerChar = unicode.ToLower(char)
		if uniqueChars[lowerChar] == false {
			numberOfUniqueChars++
			uniqueChars[lowerChar] = true
		}
	}

	return len(sentenceChars) == numberOfUniqueChars
}
