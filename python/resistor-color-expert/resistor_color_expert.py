RESISTORS = ["black", "brown", "red", "orange",
             "yellow", "green", "blue", "violet", "grey", "white"]

UNIT_PREFIX = [("", ""), ("", "0"), ("kilo", ""), ("kilo", ""), ("kilo", "0"),
               ("kilo", "000"), ("mega", ""), ("mega", "0"), ("mega", "00"), ("giga", "")]

TOLERANCES = {
    "grey": 0.05,
    "violet": 0.1,
    "blue": 0.25,
    "green": 0.5,
    "brown": 1,
    "red": 2,
    "gold": 5,
    "silver": 10
}


def resistor_label(colors):
    if len(colors) == 1:
        return "0 ohms"

    value1 = RESISTORS.index(colors[0])
    value2 = RESISTORS.index(colors[1])

    if len(colors) == 4:
        value = 10 * value1 + value2 if value2 > 0 else value1
        prefixes = UNIT_PREFIX[RESISTORS.index(colors[2])]
        tolerance = TOLERANCES.get(colors[3])

        return f"{value}{prefixes[1]} {prefixes[0]}ohms ±{tolerance}%"
    elif len(colors) == 5:
        value3 = RESISTORS.index(colors[2])
        value = 100 * value1 + (10 * value2) + value3
        prefixes = UNIT_PREFIX[RESISTORS.index(colors[3])]
        prefixed_value = int(f"{value}{prefixes[1]}")
        if prefixed_value >= 1000:
            prefixed_value = prefixed_value / 1000
            prefixes = UNIT_PREFIX[RESISTORS.index(colors[3]) + 1]

        tolerance = TOLERANCES.get(colors[4])

        return f"{prefixed_value} {prefixes[0]}ohms ±{tolerance}%"
