def rebase(input_base, digits, output_base):
    digits.reverse()
    print(digits)
    digits_in_new_base = [digit * pow(input_base, position)
                          for position, digit in enumerate(digits)]
    digits_in_new_base.reverse()
    sum_of_converted_digits = sum(digits_in_new_base)

    print(digits_in_new_base)

    return list(sum_of_converted_digits)
