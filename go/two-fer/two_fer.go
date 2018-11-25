// Package twofer implements the solution to https://exercism.io/my/solutions/4cb5ded6b5644d31bd280dd17d8ec051
package twofer

// ShareWith equally shares a undefined item between string and myself.
func ShareWith(name string) string {
	if name == "" {
		return "One for you, one for me."
	} else {
		return "One for " + name + ", one for me."
	}
}
