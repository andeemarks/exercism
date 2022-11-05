"""docstring"""
import re

ALPHABET = "abcdefghijklmnopqrstuvwxyz"
REVERSABET = ALPHABET[::-1]
MAPPINGS = str.maketrans(ALPHABET, REVERSABET)


def encode(plain_text):
    """docstring"""
    clean_text = re.compile('\\W').sub("", plain_text)
    encoded_text = clean_text.lower().translate(MAPPINGS)
    chunked_text = re.findall('\\w{1,5}', encoded_text)

    return " ".join(chunked_text)


def decode(ciphered_text):
    """docstring"""
    clean_text = ciphered_text.replace(" ", "")

    return clean_text.translate(MAPPINGS)
