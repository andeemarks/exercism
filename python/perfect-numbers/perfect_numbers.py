"""doctstring"""


def classify(number):
    """ A perfect number equals the sum of its positive divisors.

    :param number: int a positive integer
    :return: str the classification of the input integer
    """

    if number <= 0:
        raise ValueError(
            "Classification is only possible for positive integers.")

    possible_factors = range(1, (int)(number / 2) + 1)
    factors = filter(lambda factor: number % factor == 0, possible_factors)
    factor_sum = sum(factors)

    if factor_sum > number:
        return "abundant"

    if factor_sum < number:
        return "deficient"

    return "perfect"
