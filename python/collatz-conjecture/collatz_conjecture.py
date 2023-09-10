def steps(number):
    if number < 1:
        raise ValueError("Only positive integers are allowed")

    return transform(0, number)


def transform(counter, number):
    if number == 1:
        return counter

    if number % 2 == 0:
        return transform(counter + 1, number / 2)
    else:
        return transform(counter + 1, number * 3 + 1)
