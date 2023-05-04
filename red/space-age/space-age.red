Red [
	description: {"Space Age" exercise solution for exercism platform}
	author: "Andy Marks" 
]

planet_to_earth: #("Earth" 1 "Mercury" 0.2408467 "Venus" 0.61519726 "Mars" 1.8808158 "Jupiter" 11.862615 "Saturn" 29.447498 "Uranus"  84.016846 "Neptune"  164.79132)

age: function [
	planet
	seconds
] [
	earth_seconds_in_year: 31557600
	earth_age: seconds / earth_seconds_in_year

	relative_to_earth_age earth_age (select planet_to_earth planet)
]

relative_to_earth_age: function [
	earth_age
	offset
] [
	(round (earth_age  / offset * 100)) / 100
]

