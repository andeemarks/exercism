def egg_count(display_value):
    powers = find_powers_of_2_less_than(display_value)

    eggs = 0
    for power in powers:
        if power <= display_value:
            display_value = display_value - power
            eggs += 1

    return eggs


def find_powers_of_2_less_than(value):
    powers = []
    exponent = 0
    while 2 ** exponent <= value:
        powers.append(2 ** exponent)
        exponent = exponent + 1

    return reversed(powers)
