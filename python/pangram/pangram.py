"""docstring"""


def is_pangram(sentence):
    """docstring"""
    letters_only = filter(lambda letter: letter.isalpha(), sentence.lower())

    return len(set(letters_only)) == 26
