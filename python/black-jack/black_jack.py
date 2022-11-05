"""Functions to help play and score a game of blackjack.

How to play blackjack:    https://bicyclecards.com/how-to-play/blackjack/
"Standard" playing cards: https://en.wikipedia.org/wiki/Standard_52-card_deck
"""

ACE_HIGH_VALUE = 11
ACE_LOW_VALUE = 1
HAND_LIMIT = 21


def value_of_card(card):
    """Determine the scoring value of a card.

    :param card: str - given card.
    :return: int - value of a given card.  See below for values.

    1.  'J', 'Q', or 'K' (otherwise known as "face cards") = 10
    2.  'A' (ace card) = 1
    3.  '2' - '10' = numerical value.
    """

    if card == 'A':
        return ACE_LOW_VALUE

    if card in ['J', 'Q', 'K']:
        return 10

    return (int)(card)


def higher_card(card_one, card_two):
    """Determine which card has a higher value in the hand.

    :param card_one, card_two: str - cards dealt in hand.  See below for values.
    :return: str or tuple - resulting Tuple contains both cards if they are of equal value.

    1.  'J', 'Q', or 'K' (otherwise known as "face cards") = 10
    2.  'A' (ace card) = 1
    3.  '2' - '10' = numerical value.
    """

    card_one_value = value_of_card(card_one)
    card_two_value = value_of_card(card_two)

    if card_one_value == card_two_value:
        return (card_one, card_two)

    if card_one_value > card_two_value:
        return card_one

    return card_two


def value_of_ace(card_one, card_two):
    """Calculate the most advantageous value for the ace card.

    :param card_one, card_two: str - card dealt. See below for values.
    :return: int - either 1 or 11 value of the upcoming ace card.

    1.  'J', 'Q', or 'K' (otherwise known as "face cards") = 10
    2.  'A' (ace card) = 11 (if already in hand)
    3.  '2' - '10' = numerical value.
    """

    card_values = value_of_pair(card_one, card_two)

    if HAND_LIMIT - card_values >= 11:
        return ACE_HIGH_VALUE

    return ACE_LOW_VALUE


def aces_high(card_value):
    """
    Upscale the value of any aces (from 1 to 11).
    """
    if card_value == ACE_LOW_VALUE:
        card_value = ACE_HIGH_VALUE

    return card_value


def value_of_pair(card_one, card_two):
    """
    Return the sum of both card values, with aces considered high.
    """
    card_one_value = aces_high(value_of_card(card_one))
    card_two_value = aces_high(value_of_card(card_two))

    return card_one_value + card_two_value


def is_blackjack(card_one, card_two):
    """Determine if the hand is a 'natural' or 'blackjack'.

    :param card_one, card_two: str - card dealt. See below for values.
    :return: bool - is the hand is a blackjack (two cards worth 21).

    1.  'J', 'Q', or 'K' (otherwise known as "face cards") = 10
    2.  'A' (ace card) = 11 (if already in hand)
    3.  '2' - '10' = numerical value.
    """

    card_values = value_of_pair(card_one, card_two)

    if card_values == HAND_LIMIT:
        return True

    return False


def can_split_pairs(card_one, card_two):
    """Determine if a player can split their hand into two hands.

    :param card_one, card_two: str - cards dealt.
    :return: bool - can the hand be split into two pairs? (i.e. cards are of the same value).
    """

    card_one_value = aces_high(value_of_card(card_one))
    card_two_value = aces_high(value_of_card(card_two))

    return card_one_value == card_two_value


DOUBLE_DOWN_MAX = 11
DOUBLE_DOWN_MIN = 9


def can_double_down(card_one, card_two):
    """Determine if a blackjack player can place a double down bet.

    :param card_one, card_two: str - first and second cards in hand.
    :return: bool - can the hand can be doubled down? (i.e. totals 9, 10 or 11 points).
    """

    card_one_value = value_of_card(card_one)
    card_two_value = value_of_card(card_two)
    card_values = card_one_value + card_two_value

    return DOUBLE_DOWN_MAX >= card_values >= DOUBLE_DOWN_MIN
