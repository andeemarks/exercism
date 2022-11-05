"""docstring"""

import string

LOWER_PLAINTEXT = string.ascii_lowercase
UPPER_PLAINTEXT = string.ascii_uppercase


def rotate(text, key):
    """docstring"""

    key = key % 26

    transposed_lower_letters = "".join(
        (2 * list(LOWER_PLAINTEXT))[key:(key+26)])
    transposed_upper_letters = "".join(
        (2 * list(UPPER_PLAINTEXT))[key:(key+26)])

    translations = str.maketrans(LOWER_PLAINTEXT + UPPER_PLAINTEXT,
                                 transposed_lower_letters + transposed_upper_letters)

    return text.translate(translations)
