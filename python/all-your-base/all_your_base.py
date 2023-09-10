def rebase(input_base, digits, output_base):
    check_valid_request(input_base, digits, output_base)

    digits_in_base_10 = [digit * pow(input_base, position)
                          for position, digit in enumerate(digits[::-1])]

    sum_of_converted_digits = sum(digits_in_base_10)

    if (sum_of_converted_digits == 0):
        return [0]
    else:
        return convert_to_base(sum_of_converted_digits, output_base)


def convert_to_base(number, base):
    converted_digits = []
    for place in range (find_highest_place_less_than(number, base), -1, -1):
        place_value = pow(base, place)
        converted_digits.append(number // place_value)
        if number >= place_value:
            number = number % place_value

    return converted_digits

def find_highest_place_less_than(number, base):
    for place in range(0, number + 1):
        if (pow(base, place) > number):
            return place - 1
    
    return place
    
def check_valid_request(input_base, digits, output_base):
    if input_base < 2:
        raise ValueError("input base must be >= 2")

    if output_base < 2:
        raise ValueError("output base must be >= 2")
    
    if len(list(filter(lambda digit: conforms_to_base(digit, input_base), digits))) > 0:
        raise ValueError("all digits must satisfy 0 <= d < input base")

def conforms_to_base(digit, base):
    return digit < 0 or digit >= base
