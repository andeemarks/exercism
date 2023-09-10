from functools import reduce

def is_armstrong_number(number):
    digits = [int(i) for i in str(number)]
    result = sum(map(lambda digit: pow(digit, len(digits)) , digits))

    return result == number
