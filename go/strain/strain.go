// Package strain implements the exercism.io String solution
package strain

// Ints represents a list of int values
type Ints []int

// Strings represents a list of string values
type Strings []string

// Lists represents a list of int lists
type Lists [][]int

// Keep will apply fn and return all values from the Ints for which fn returns true
func (i Ints) Keep(fn func(int) bool) (result Ints) {
	for _, value := range i {
		if fn(value) {
			result = append(result, value)
		}
	}
	return
}

// Discard will apply fn and return all values from the Ints for which fn returns false
func (i Ints) Discard(fn func(int) bool) (result Ints) {
	for _, value := range i {
		if !fn(value) {
			result = append(result, value)
		}
	}
	return
}

// Keep will apply fn and return all values from the Lists for which fn returns true
func (l Lists) Keep(fn func([]int) bool) (result Lists) {
	for _, value := range l {
		if fn(value) {
			result = append(result, value)
		}
	}
	return
}

// Keep will apply fn and return all values from the Strings for which fn returns true
func (s Strings) Keep(fn func(string) bool) (result Strings) {
	for _, value := range s {
		if fn(value) {
			result = append(result, value)
		}
	}
	return
}
