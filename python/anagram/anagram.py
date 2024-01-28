def find_anagrams(word, candidates):
    hashed_word = hash_word(word)

    return [anagram for anagram in candidates if hash_word(anagram)
            == hashed_word and anagram.lower() != word.lower()]


def hash_word(word):
    return ''.join(sorted(word.lower()))
