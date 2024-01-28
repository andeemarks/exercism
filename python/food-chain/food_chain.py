ordered_food = [
    None, 
    {'Name': 'fly', 'Desc': ''}, 
    {'Name': 'spider', 'Desc': 'It wriggled and jiggled and tickled inside her.', 'Catches': 'fly'},
    {'Name': 'bird', 'Desc': 'How absurd to swallow a bird!', 'Catches': 'spider that wriggled and jiggled and tickled inside her'},
    {'Name': 'cat', 'Desc': 'Imagine that, to swallow a cat!', 'Catches': 'bird'},
    {'Name': 'dog', 'Desc': 'What a hog, to swallow a dog!', 'Catches': 'cat'},
    {'Name': 'goat', 'Desc': 'Just opened her throat and swallowed a goat!', 'Catches': 'dog'},
    {'Name': 'cow', 'Desc': "I don't know how she swallowed a cow!", 'Catches': 'goat'},
    {'Name': 'horse', 'Desc': "She's dead, of course!"}
    ]

finale = [
        f"I don't know why she swallowed the fly. Perhaps she'll die."]

def opening_line(verse):
    return f'I know an old lady who swallowed a {ordered_food[verse]["Name"]}.'

def joining_line(verse):
    return f'She swallowed the {ordered_food[verse]["Name"]} to catch the {ordered_food[verse]["Catches"]}.'

def second_line(verse):
    return ordered_food[verse]['Desc']

def recite(start_verse, end_verse):
    lyrics = []
    for verse in range(start_verse, end_verse + 1):
        lyrics += recite_verse(verse)
        lyrics += [""] if verse != end_verse else []

    return lyrics

def recite_verse(verse):
    lyrics = [opening_line(verse)]

    if verse == len(ordered_food) - 1:
        return lyrics + [second_line(verse)]
    
    for line in range(verse, 1, -1):
        if (verse ==  line):
            lyrics += [second_line(line)]
        lyrics += [joining_line(line)]

    return lyrics + finale
