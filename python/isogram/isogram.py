"""docstring"""


def is_isogram(string):
    """docstring"""

    letters_only = list(
        filter(lambda letter: letter.isalpha(), string.lower()))

    return len(set(letters_only)) == len(letters_only)
