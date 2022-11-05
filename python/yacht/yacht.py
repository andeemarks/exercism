"""docstring"""

from statistics import mode

# Score categories.
# Change the values as you see fit.
YACHT = 0
ONES = 1
TWOS = 2
THREES = 3
FOURS = 4
FIVES = 5
SIXES = 6
FULL_HOUSE = 7
FOUR_OF_A_KIND = 8
LITTLE_STRAIGHT = 9
BIG_STRAIGHT = 10
CHOICE = 11


def most_common(dice):
    """docstring"""

    return mode(dice)


def all_die_of_value(value, dice):
    """docstring"""

    return list(filter(lambda die: die == value, dice))


def score(dice, category):
    """docstring"""

    number_of_unique_die = len(set(dice))
    die_counts = {die: dice.count(die) for die in dice}.values()
    is_four_of_a_kind = (len(die_counts) == 2) & (sorted(die_counts) == [1, 4])
    is_five_of_a_kind = len(die_counts) == 1

    switch = {
        YACHT: 50 if len(set(dice)) == 1 else 0,
        ONES: category * len(all_die_of_value(category, dice)),
        TWOS: category * len(all_die_of_value(category, dice)),
        THREES: category * len(all_die_of_value(category, dice)),
        FOURS: category * len(all_die_of_value(category, dice)),
        FIVES: category * len(all_die_of_value(category, dice)),
        SIXES: category * len(all_die_of_value(category, dice)),
        FULL_HOUSE: sum(dice) if ((number_of_unique_die == 2) & (not is_four_of_a_kind)) else 0,
        FOUR_OF_A_KIND: 4 * most_common(dice) if is_four_of_a_kind | is_five_of_a_kind else 0,
        LITTLE_STRAIGHT: 30 if sorted(dice) == [1, 2, 3, 4, 5] else 0,
        BIG_STRAIGHT: 30 if sorted(dice) == [2, 3, 4, 5, 6] else 0,
        CHOICE: sum(dice),
    }

    return switch.get(category)
