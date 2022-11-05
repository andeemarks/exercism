"""docstring"""


def equilateral(sides):
    """docstring"""

    return len(set(sides)) == 1 & (max(sides) > 0)


def satisfies_triangle_equality(sides):
    """docstring"""

    smallest_side = min(sides)
    largest_side = max(sides)

    return (smallest_side * 2) > largest_side


def isosceles(sides):
    """docstring"""

    number_of_unique_sides = len(set(sides))

    return (number_of_unique_sides <= 2) & satisfies_triangle_equality(sides)


def scalene(sides):
    """docstring"""

    number_of_unique_sides = len(set(sides))

    return (number_of_unique_sides == 3) & satisfies_triangle_equality(sides)
