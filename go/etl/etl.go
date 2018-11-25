// Package etl implements the exercism.io Transform solution
package etl

import (
	"strings"
)

// Transform reformats the input map into the result, mapping the input key as the value of each element of the result
func Transform(input map[int][]string) map[string]int {
	var result = make(map[string]int, 26)
	for points, letters := range input {
		for _, letter := range letters {
			result[strings.ToLower(letter)] = points
		}
	}

	return result
}
