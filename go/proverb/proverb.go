// Package proverb implements the exercism.io proverb solution
package proverb

import "fmt"

// LineCollection holds the lines of the Proverb
type LineCollection []string

func (lc LineCollection) addSuffix(terms []string) LineCollection {
	if len(terms) == 0 {
		return lc
	}

	return append(lc, fmt.Sprintf("And all for the want of a %s.", terms[0]))
}

func (lc LineCollection) addLine(term1 string, term2 string) LineCollection {
	return append(lc, fmt.Sprintf("For want of a %s the %s was lost.", term1, term2))
}

// Proverb returns the full proverb generated from the list of input rhymes
func Proverb(rhyme []string) []string {
	var lc = LineCollection{}

	for i := 0; i < len(rhyme)-1; i++ {
		lc = lc.addLine(rhyme[i], rhyme[i+1])
	}

	return lc.addSuffix(rhyme)
}
