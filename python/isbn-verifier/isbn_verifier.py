"""docstring"""

import re


def is_valid(isbn):
    """docstring"""
    chars_only = isbn.replace("-", "")

    if not re.match('^[0-9]{9,9}[0-9|X]$', chars_only):
        return False

    digits = list(map(int, chars_only[:-1]))

    checkdigit = chars_only[-1]

    if checkdigit.isdigit():
        digits.append((int)(checkdigit))
    else:
        digits.append(10)

    checksum = sum([(i + 1) * digit for i, digit in enumerate(digits)])

    return (checksum % 11) == 0
