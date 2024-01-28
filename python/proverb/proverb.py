def proverb(*inputs, qualifier):
    result = []
    for i in range(0, len(inputs) - 1):
        result.append(f"For want of a {inputs[i]} the {inputs[i + 1]} was lost.")

    if (len(inputs) > 0):
        result.append(f"And all for the want of a {qualifier + ' ' if qualifier else ''}{inputs[0]}.")

    return result
