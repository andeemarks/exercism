bracket_pairs = {'[': ']', '(': ')', '{': '}'}

def is_paired(input_string):
    matching_closing_brackets = []

    for char in clean_input(input_string):
        if char in bracket_pairs:
            matching_closing_brackets.append(bracket_pairs[char])
        elif len(matching_closing_brackets) > 0 and char == matching_closing_brackets[-1]:
            matching_closing_brackets.pop()
        else:
            return False

    return len(matching_closing_brackets) == 0

def clean_input(input):
    return ''.join(char for char in input if char in bracket_pairs.keys() or char in bracket_pairs.values())