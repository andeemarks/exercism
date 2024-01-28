"""
Stolen entirely from https://www.rosettacode.org/wiki/Isqrt_(integer_square_root)_of_X#Python
"""
def square_root(number):
    q = lowest_power_of_4_greater_than(number)

    z = number
    integer_square_root = 0

    while q > 1 :
        q  /= 4
        t = z - integer_square_root - q
        integer_square_root /= 2
        if t >= 0:
            z = t
            integer_square_root += q

    return integer_square_root 

def lowest_power_of_4_greater_than(number):
    q = 1

    while q <= number : 
        q *= 4

    return q
