package space

const earthYearInSeconds float64 = 31557600

// Age with calculate/return the number of seconds an individual is on a given planet.
func Age(seconds float64, planet Planet) float64 {
	earthRelativePlanetYears := map[Planet]float64{
		"Earth":   1,
		"Mercury": 0.2408467,
		"Venus":   0.61519726,
		"Mars":    1.8808158,
		"Jupiter": 11.862615,
		"Saturn":  29.447498,
		"Uranus":  84.016846,
		"Neptune": 164.79132,
	}

	return seconds / (earthYearInSeconds * earthRelativePlanetYears[planet])
}

// Planet is a holder for the name of a celestial body.
type Planet string
