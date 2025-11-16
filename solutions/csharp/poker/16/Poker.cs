using System.Text;
using Score = ulong;

public static class Poker
{
    public static IEnumerable<string> BestHands(IEnumerable<string> hands)
    {
        var scoredHands = ScoreHands(hands);
        var sortedHands = SortHandsByScore(scoredHands);

        return GetWinningHand(sortedHands);
    }

    private static IEnumerable<string> GetWinningHand(List<Tuple<HandScore, string>> sortedHands)
    {
        var highestScore = sortedHands.First().Item1;
     
        return sortedHands.Where(hand => hand.Item1.Equals(highestScore)).Select(hand => hand.Item2);
    }

    public static List<Tuple<HandScore, string>> ScoreHands(IEnumerable<string> hands)
    {
        return [.. hands.Select(ScoreHand)];
    }

    private static Tuple<HandScore, string> ScoreHand(string hand)
    {
        IEnumerable<Card> cards = hand.Split(" ").Select(c => new Card(c));

        Card[] cardsByRank = [.. cards.OrderByDescending(card => Card.RankScore(card))];
        Score multipleScore = ScoreMultiples(cardsByRank);
        Score rankScore = ScoreRanks(cardsByRank);

        return new Tuple<HandScore, string>(new HandScore(multipleScore, rankScore), hand);
    }

    private static List<Tuple<HandScore, string>> SortHandsByScore(List<Tuple<HandScore, string>> sortedHands)
    {
        sortedHands.Sort((score1, score2) => score2.Item1.CompareTo(score1.Item1));

        return sortedHands;
    }

    private static Score ScoreMultiples(IEnumerable<Card> cards)
    {
        var ranks = cards.Select(c => c.rank);
        var groupedRanks = ranks.GroupBy(r => r);
        var threeOfAKind = groupedRanks.Where(group => group.Count() == 3);

        var handScores = new Dictionary<PokerHand, Score>
        {
            {PokerHand.STRAIGHT_FLUSH,             (Score)Math.Pow(10, 11) },
            {PokerHand.FIVE_HIGH_STRAIGHT_FLUSH,   (Score)Math.Pow(10, 10) },
            {PokerHand.FOUR_OF_A_KIND,             (Score)Math.Pow(10, 8) },
            {PokerHand.FULL_HOUSE,                 (Score)Math.Pow(10, 7) },
            {PokerHand.FLUSH,                      (Score)Math.Pow(10, 6) },
            {PokerHand.STRAIGHT,                   (Score)Math.Pow(10, 5) },
            {PokerHand.FIVE_HIGH_STRAIGHT,         (Score)Math.Pow(10, 4) },
            {PokerHand.THREE_OF_A_KIND,            (Score)Math.Pow(10, 3) },
            {PokerHand.TWO_PAIR,                   (Score)Math.Pow(10, 2) },
            {PokerHand.ONE_PAIR,                   (Score)Math.Pow(10, 1) },
            {PokerHand.NONE,                       0 },
        };

        PokerHand hand = IdentifyHand(cards);
        var score = handScores[hand];

        switch (hand)
        {
            case PokerHand.STRAIGHT_FLUSH:
                var highestCard = Card.RankScore(cards.First());

                return score + highestCard;
            case PokerHand.FOUR_OF_A_KIND:
                var fourOfAKind = groupedRanks.Where(group => group.Count() == 4);
                var kicker = Card.RankScore(groupedRanks.Where(group => group.Count() == 1).First().Key);

                return score * Card.RankScore(fourOfAKind.First().Key) + kicker;
            case PokerHand.FULL_HOUSE:
                var tripletScore = Card.RankScore(threeOfAKind.First().Key);
                var pairs = groupedRanks.Where(group => group.Count() == 2);
                var pairScore = Card.RankScore(pairs.First().Key);

                return score * tripletScore + pairScore;
            case PokerHand.THREE_OF_A_KIND:
                return score * Card.RankScore(threeOfAKind.First().Key);
            default:
                return score;
        }
    }

    private static PokerHand IdentifyHand(IEnumerable<Card> cards)
    {
        var ranks = cards.Select(c => c.rank);
        var groupedRanks = ranks.GroupBy(r => r);
        var pairs = groupedRanks.Where(group => group.Count() == 2);

        var isFlush = IsFlush(cards);
        var isThreeOfAKind = groupedRanks.Where(group => group.Count() == 3).Any();
        var isStraight = IsStraight(cards, ranks, groupedRanks);
        var isFiveHighStraight = IsFiveHighStraight(cards, ranks, groupedRanks);

        if (isFlush)
        {
            if (isStraight)
            {
                return PokerHand.STRAIGHT_FLUSH;
            }
            if (isFiveHighStraight)
            {
                return PokerHand.FIVE_HIGH_STRAIGHT_FLUSH;
            }
        }

        if (groupedRanks.Where(group => group.Count() == 4).Any())
        {
            return PokerHand.FOUR_OF_A_KIND;
        }

        if (isThreeOfAKind)
        {
            return pairs.Count() == 1 ? PokerHand.FULL_HOUSE : PokerHand.THREE_OF_A_KIND;
        }

        if (isFlush)
        {
            return PokerHand.FLUSH;
        }

        if (isFiveHighStraight)
        {
            return PokerHand.FIVE_HIGH_STRAIGHT;
        }

        if (isStraight)
        {
            return PokerHand.STRAIGHT;
        }

        if (pairs.Count() == 2)
        {
            return PokerHand.TWO_PAIR;
        }

        return pairs.Count() == 1 ? PokerHand.ONE_PAIR : PokerHand.NONE;
    }

    private static bool IsStraight(IEnumerable<Card> cards, IEnumerable<string> ranks, IEnumerable<IGrouping<string, string>> groupedRanks)
    {
        var lowestRank = Card.RankScore(cards.Last());
        var highestRank = Card.RankScore(cards.First());
        var isOnlyUniqueRanks = groupedRanks.Count() == ranks.Count();
        var rankSpan = highestRank - lowestRank;

        return isOnlyUniqueRanks && rankSpan == 4;
    }
    private static bool IsFiveHighStraight(IEnumerable<Card> cards, IEnumerable<string> ranks, IEnumerable<IGrouping<string, string>> groupedRanks)
    {
        var lowestRank = Card.RankScore(cards.Last());
        var hasAce = cards.First().rank == "A";
        var secondHighestRank = Card.RankScore(cards.ElementAt(1));
        var isOnlyUniqueRanks = groupedRanks.Count() == ranks.Count();
        var rankSpan = secondHighestRank - lowestRank;

        return isOnlyUniqueRanks && hasAce & rankSpan == 3;
    }

    private static bool IsFlush(IEnumerable<Card> cards)
    {
        var suits = cards.Select(c => c.suit);
        var groupedSuits = suits.GroupBy(s => s);

        return groupedSuits.Count() == 1;
    }

    private static Score ScoreRanks(IEnumerable<Card> cards)
    {
        StringBuilder score = cards.Aggregate(new StringBuilder(), (sb, card) => sb.Append(Card.PaddedRankScore(card.rank)));

        return ulong.Parse(score.ToString());
    }
}

internal enum PokerHand
{
    STRAIGHT_FLUSH,
    FOUR_OF_A_KIND,
    FULL_HOUSE,
    FLUSH,
    STRAIGHT,
    FIVE_HIGH_STRAIGHT,
    THREE_OF_A_KIND,
    TWO_PAIR,
    ONE_PAIR,
    NONE,
    FIVE_HIGH_STRAIGHT_FLUSH
}

public class HandScore(Score baseScore, Score discriminator) : IComparable<HandScore>
{
    public readonly Score baseScore = baseScore;
    public readonly Score discriminator = discriminator;

    public int CompareTo(HandScore? other)
    {
        if (other == null) return 1;

        int baseComparison = baseScore.CompareTo(other.baseScore);

        return baseComparison != 0 ? baseComparison : discriminator.CompareTo(other.discriminator);
    }

    public override string ToString() => string.Format("base: {0}, disc.: {1}", baseScore, discriminator);

    public override bool Equals(object? obj)
    {
        if (obj == null)
        {
            return false;
        }

        if (ReferenceEquals(this, obj))
        {
            return true;
        }

        if (obj is not HandScore other)
        {
            return false;
        }

        return baseScore == other.baseScore && discriminator == other.discriminator;
    }

    public override int GetHashCode() => base.GetHashCode();
}

public class Card(string card): IComparable<Card>
{
    public readonly string rank = card[..^1];
    public readonly string suit = card.Substring(card.Length - 1, 1);

    public static Score RankScore(string rank) => rank switch
    {
        "A" => 14,
        "K" => 13,
        "Q" => 12,
        "J" => 11,
        _ => (Score)short.Parse(rank),
    };
    public static Score RankScore(Card card) => Card.RankScore(card.rank);

    public override string ToString() => String.Format("{0}{1}", rank, suit);

    public static string PaddedRankScore(string rank) => Card.RankScore(rank).ToString().PadLeft(2, '0');
    public int CompareTo(Card? other) => other == null ? 1 : RankScore(rank).CompareTo(other.rank);
}