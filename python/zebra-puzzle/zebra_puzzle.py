from icecream import ic
from collections import namedtuple

all_colours = ['red', 'green', 'ivory', 'yellow', 'blue']
all_pets = ['dog', 'zebra', 'snails', 'fox', 'horse']
all_drinks = ['coffee', 'tea', 'water', 'milk', 'orange juice']
all_occupants = ['english', 'spanish', 'ukranian', 'norweigan', 'japanese']
all_cigarettes = ['old gold', 'kools', 'lucky strike', 'parliaments', 'chesterfields']
all_positions = [1, 2, 3, 4, 5]

def setup_facts():
    House = namedtuple('House', 
                       ['position', 'colour', 'occupant', 'beverage', 'cigarette', 'pet'], 
                       defaults=[all_positions, all_colours, all_occupants, all_drinks, all_cigarettes, all_pets])

    # 1. There are five houses.
    facts = []


    # 2. The Englishman lives in the red house.
    english_house = House(occupant="english", colour="red")
    facts.append(english_house)

    # 3. The Spaniard owns the dog.
    spanish_house = House(occupant="spanish", pet="dog")
    facts.append(spanish_house)

    # 4. Coffee is drunk in the green house.
    coffee_house = House(colour = "green", beverage = "coffee")
    facts.append(coffee_house)

    # 5. The Ukrainian drinks tea.
    ukranian_house = House(occupant = "ukranian", beverage = "tea")
    facts.append(ukranian_house)

    # 6. The green house is immediately to the right of the ivory house.
    ivory_house = House(colour = "ivory")
    facts.append(ivory_house)

    # green_house = House(colour = "green", position = ivory_house.position + 1)
    # facts.append(green_house)

    # 7. The Old Gold smoker owns snails.
    snail_house = House(pet = "snails", cigarette = "old gold")
    facts.append(snail_house)

    # 8. Kools are smoked in the yellow house.
    yellow_house = House(colour = "yellow", cigarette = "kools")
    facts.append(yellow_house)

    # 9. Milk is drunk in the middle house.
    middle_house = House(beverage = "milk", position = 3)
    facts.append(middle_house)

    # 10. The Norwegian lives in the first house.
    norweigan_house = House(occupant = "norweigan", position = 1)
    facts.append(norweigan_house)

    # 11. The man who smokes Chesterfields lives in the house next to the man with the fox.

    # 12. Kools are smoked in the house next to the house where the horse is kept.

    # 13. The Lucky Strike smoker drinks orange juice.
    juice_house = House(beverage = "orange juice", cigarette = "lucky strike")
    facts.append(juice_house)

    # 14. The Japanese smokes Parliaments.
    japanese_house = House(occupant = "japanese", cigarette = "parliaments")
    facts.append(japanese_house)

    # 15. The Norwegian lives next to the blue house.
    blue_house = House(colour = "blue", position = 2)
    facts.append(blue_house)

    # facts.sort(key=lambda house: house.position)

    positioned_houses = [House(position = 1), House(position = 2), House(position = 3), House(position = 4), House(position = 5)]
    positioned_houses[0] = norweigan_house
    positioned_houses[1] = blue_house
    positioned_houses[2] = middle_house
    
    ic(facts)
    ic(len(facts))

    return facts

def drinks_water():
    facts = setup_facts()

    matches = list(filter(lambda facts: facts.beverage == "water", facts))

    if len(matches) == 1:
        return matches[0].occupant_nationality
    else:
        print(f"Found {len(matches)} matches")
        return None

def owns_zebra():
    facts = setup_facts()

    matches = list(filter(lambda facts: facts.pet == "zebra", facts))

    if len(matches) == 1:
        return matches[0].occupant_nationality
    else:
        print(f"Found {len(matches)} matches")
        return None
