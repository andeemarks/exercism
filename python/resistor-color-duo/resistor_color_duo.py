RESISTORS = ["black", "brown", "red", "orange",
             "yellow", "green", "blue", "violet", "grey", "white"]


def value(colors):
    return 10 * RESISTORS.index(colors[0]) + RESISTORS.index(colors[1])
