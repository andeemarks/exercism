Red [
	description: {"Darts" exercise solution for exercism platform}
	author: "" ; you can write your name here, in quotes
]

score: function [
	x
	y
] [
	distance_from_centre: sqrt((x * x) + (y * y))
	case [
		distance_from_centre > 10 [ 0 ]
		distance_from_centre > 5 [ 1 ]
		distance_from_centre > 1 [ 5 ] 
		'bullseye 10
	]
]

