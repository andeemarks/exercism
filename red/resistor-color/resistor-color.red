Red [
	description: {"Resistor Color" exercise solution for exercism platform}
	author: "" ; you can write your name here, in quotes
]

color-codes: make map! ["black" 0 "brown" 1 "red" 2 "orange" 3 "yellow" 4 "green" 5 "blue" 6 "violet" 7 "grey" 8 "white" 9]
color-code: function [
	color
] [
	select color-codes color
]

colors: function [] [
	keys-of color-codes
]

