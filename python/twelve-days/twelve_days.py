GIFTS = [
    ("first", "a Partridge in a Pear Tree."),
    ("second", "two Turtle Doves, "),
    ("third", "three French Hens, "),
    ("fourth", "four Calling Birds, "),
    ("fifth", "five Gold Rings, "),
    ("sixth", "six Geese-a-Laying, "),
    ("seventh", "seven Swans-a-Swimming, "),
    ("eighth", "eight Maids-a-Milking, "),
    ("ninth", "nine Ladies Dancing, "),
    ("tenth", "ten Lords-a-Leaping, "),
    ("eleventh", "eleven Pipers Piping, "),
    ("twelfth", "twelve Drummers Drumming, ")
]


def opening(verse):
    return [
        f"On the {GIFTS[verse][0]} day of Christmas my true love gave to me: ",
        GIFTS[verse][1]
    ]


def recite_verse_gifts(verse_number):
    verse_gifts = []
    for verse_index in range(verse_number - 1, 0, -1):
        verse_gifts.append(GIFTS[verse_index][1])

    if (verse_number >= 1):
        verse_gifts.append(f"and {GIFTS[0][1]}")

    return verse_gifts


def recite_verse(verse_number):
    return opening(verse_number) + recite_verse_gifts(verse_number)


def recite(start_verse, end_verse):
    return [''.join(recite_verse(verse)) for verse in range(start_verse - 1, end_verse)]
