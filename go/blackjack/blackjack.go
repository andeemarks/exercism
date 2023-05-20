package blackjack

// ParseCard returns the integer value of a card following blackjack ruleset.
func ParseCard(card string) int {
	switch card {
	case "one":
		return 1
	case "two":
		return 2
	case "three":
		return 3
	case "four":
		return 4
	case "five":
		return 5
	case "six":
		return 6
	case "seven":
		return 7
	case "eight":
		return 8
	case "nine":
		return 9
	case "ten", "jack", "queen", "king":
		return 10
	case "ace":
		return 11
	default:
		return 0
	}
}

const PairOfAces int = 22
const Blackjack int = 21

// FirstTurn returns the decision for the first turn, given two cards of the
// player and one card of the dealer.
func FirstTurn(card1, card2, dealerCard string) string {
	playerHand := ParseCard(card1) + ParseCard(card2)
	dealerHand := ParseCard(dealerCard)

	switch {
	case playerHand == PairOfAces:
		return "P"
	case playerHand == Blackjack:
		if dealerHand < 10 {
			return "W"
		} else {
			return "S"
		}
	case between(playerHand, 17, 20):
		return "S"
	case between(playerHand, 12, 16):
		if dealerHand >= 7 {
			return "H"
		} else {
			return "S"
		}
	case playerHand <= 11:
		return "H"
	default:
		return "?"
	}
}

func between(value, lower, upper int) bool {
	return value >= lower && value <= upper
}
