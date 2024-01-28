def is_bit_on_at(binary_str, position):
    binary = int(binary_str, base=2)

    return binary & (1 << position) > 0


def commands(binary_str):
    actions = []

    if is_bit_on_at(binary_str, 0):
        actions.append("wink")
    if is_bit_on_at(binary_str, 1):
        actions.append("double blink")
    if is_bit_on_at(binary_str, 2):
        actions.append("close your eyes")
    if is_bit_on_at(binary_str, 3):
        actions.append("jump")
    if is_bit_on_at(binary_str, 4):
        actions.reverse()

    return actions
