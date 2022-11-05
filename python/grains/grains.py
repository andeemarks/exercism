"""docstring"""

ALL_SQUARES = range(1, 65)


def square(number):
    """docstring"""
    if number in ALL_SQUARES:
        return pow(2, number - 1)

    raise ValueError("square must be between 1 and 64")


def total():
    """docstring"""

    return sum(square(number) for number in ALL_SQUARES)
