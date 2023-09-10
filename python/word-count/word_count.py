import re

def count_words(sentence):
    words = sentence_to_words(sentence)
    word_counts = dict.fromkeys(set(words), 1)

    for word in word_counts:
        word_counts[word] = words.count(word)

    return word_counts

def sentence_to_words(sentence):
    WORD_DELIMITERS = ":,_"
    words = re.sub(rf'[{WORD_DELIMITERS}]+', ' ', sentence.lower()).split()
    words = list(map(remove_noise_chars, words))

    return words

def remove_noise_chars(word):
    word_without_leading_noise = re.sub('^\W+', '', word)
    word_without_any_noise = re.sub('\W+$', '', word_without_leading_noise)

    return word_without_any_noise