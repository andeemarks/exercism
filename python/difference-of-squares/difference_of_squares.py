def square_of_sum(number):
    return square(sum(range(number + 1)))


def sum_of_squares(number):
    return sum(map(square, range(number + 1)))


def square(number):
    return number ** 2


def difference_of_squares(number):
    return square_of_sum(number) - sum_of_squares(number)
