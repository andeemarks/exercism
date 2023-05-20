// Package weather exists.
package weather

// CurrentCondition is a thing.
var CurrentCondition string

// CurrentLocation is a thing.
var CurrentLocation string

// Forecast does stuff.
func Forecast(city, condition string) string {
	CurrentLocation, CurrentCondition = city, condition
	return CurrentLocation + " - current weather condition: " + CurrentCondition
}
