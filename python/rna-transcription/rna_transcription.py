"""docstring"""

TRANSLATIONS = {"C": "G", "G": "C", "T": "A", "A": "U"}


def translate(dna_char):
    """docstring"""

    return TRANSLATIONS[dna_char] if dna_char in TRANSLATIONS else ""


def to_rna(dna_strand):
    """docstring"""
    return "".join(map(translate, dna_strand))
