def distance(strand_a, strand_b):
    if len(strand_a) != len(strand_b):
        raise ValueError("Strands must be of equal length.")

    result = 0

    for pair in zip(strand_a, strand_b):
        if pair[0] != pair[1]:
            result += 1

    return result
