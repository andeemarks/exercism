from __future__ import annotations
import math

class Rational:
    def __init__(self, numer: int, denom: int):
        gcd = math.gcd(int(numer), int(denom))

        standard_form = -1 if denom < 0 else 1
            
        self.a = numer / gcd * standard_form
        self.b = (denom / gcd) * standard_form if numer != 0 else 1
    
    def __eq__(self, other):
        return self.a == other.a and self.b == other.b

    def __repr__(self):
        return f'{self.a}/{self.b}'

    def __add__(self, other: Rational):
        return Rational(self.a * other.b + self.b * other.a, self.b * other.b)

    def __sub__(self, other):
        return Rational(self.a * other.b - self.b * other.a, self.b * other.b)

    def __mul__(self, other):
        return Rational(self.a * other.a, self.b * other.b)

    def __truediv__(self, other):
        return Rational(self.a * other.b, self.b * other.a)

    def __abs__(self):
        return Rational(abs(self.a), abs(self.b))

    def __pow__(self, power):
        if power > 0:
            return Rational(self.a ** power, self.b ** power)
        else:
            return Rational(self.b ** abs(power), self.a ** abs(power))

    def __rpow__(self, base):
        # nth roof of x = x**(1/n)
        return (base ** self.a) ** (1/self.b)
