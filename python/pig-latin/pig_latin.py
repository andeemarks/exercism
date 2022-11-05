"""docstring"""

VOWELS = ["a", "e", "i", "o", "u"]
VOWEL_SOUNDS = VOWELS + ["xr", "yt"]


def translate_word(word):
    """docstring"""
    starts_with_vowel = any([word.startswith(prefix)
                             for prefix in VOWEL_SOUNDS])

    if starts_with_vowel:
        return suffix(word)

    vowel_occurences = [ch in VOWELS for ch in word]
    has_vowels = any(vowel_occurences)

    if has_vowels:
        if word[1:3] == "qu":
            return suffix(word, 3)

        if word[:2] == "qu":
            return suffix(word, 2)

        first_vowel_position = vowel_occurences.index(True)
        return suffix(word, first_vowel_position)

    return suffix(word, word.index("y"))


def suffix(word, pivot=0):
    """docstring"""

    return word[pivot:] + word[:pivot] + "ay"


def translate(text):
    """docstring"""

    return " ".join(map(translate_word, text.split(" ")))
