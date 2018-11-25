// Package accumulate implements the exercism.io Accumulate solution
package accumulate

// Accumulate provides a 'map' like ability to apply the converter to each element of input, returning an equivalent slice of results in result.
func Accumulate(input []string, converter func(string) string) (result []string) {
	for _, value := range input {
		result = append(result, converter(value))
	}
	return
}
