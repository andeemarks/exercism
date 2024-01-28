NUMERALS = {0: "", 1: "I", 2: "II", 3: "III", 4: "IV", 5: "V",
            6: "VI", 7: "VII", 8: "VIII", 9: "IX", 10: "X", 100: "C", 1000: "M"}


def digits(number):
    return NUMERALS[number % 10]


def tens(number):
    return NUMERALS[10] * number


def hundreds(number):
    return NUMERALS[100] * number


def thousands(number):
    return NUMERALS[1000] * number


def separate_quantity(number, unit):
    quantity = number // unit
    remainder = number - quantity * unit

    return quantity, remainder


def separate_tens(number):
    return separate_quantity(number, 10)


def separate_hundreds(number):
    return separate_quantity(number, 100)


def separate_thousands(number):
    return separate_quantity(number, 1000)


def roman(number):

    if (number <= 10):
        return digits(number)
    if (number <= 40):
        quantity, remainder = separate_tens(number)
        return f"{tens(quantity)}{roman(remainder)}"
    if (number < 50):
        quantity, remainder = separate_tens(number)
        return f"{tens(5 - quantity)}L{roman(remainder)}"
    if (number < 90):
        quantity, remainder = separate_tens(number)
        return f"L{tens(quantity - 5)}{roman(remainder)}"
    if (number < 100):
        quantity, remainder = separate_tens(number)
        return f"XC{roman(remainder)}"
    if (number < 400):
        quantity, remainder = separate_hundreds(number)
        return f"{hundreds(quantity)}{roman(remainder)}"
    if (number < 500):
        quantity, remainder = separate_hundreds(number)
        return f"{hundreds(5 - quantity)}D{roman(remainder)}"
    if (number < 900):
        quantity, remainder = separate_hundreds(number)
        return f"D{hundreds(quantity - 5)}{roman(remainder)}"
    if (number < 1000):
        quantity, remainder = separate_hundreds(number)
        return f"{hundreds(quantity - 8)}M{roman(remainder)}"
    else:
        quantity, remainder = separate_thousands(number)
        return f"{thousands(quantity)}{roman(remainder)}"
