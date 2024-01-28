RESISTORS = ["black", "brown", "red", "orange",
             "yellow", "green", "blue", "violet", "grey", "white"]

UNIT_PREFIX = [("", ""), ("", "0"), ("kilo", ""), ("kilo", ""), ("kilo", "0"),
               ("kilo", "000"), ("mega", ""), ("mega", "0"), ("mega", "00"), ("giga", "")]


def label(colors):
    value1 = RESISTORS.index(colors[0])
    value2 = RESISTORS.index(colors[1])

    value = 10 * value1 + value2 if value2 > 0 else value1

    prefixes = UNIT_PREFIX[RESISTORS.index(colors[2])]

    return f"{value}{prefixes[1]} {prefixes[0]}ohms"
