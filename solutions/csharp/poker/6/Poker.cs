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
        var scoredHands = new List<Tuple<HandScore, string>>();
        foreach (var hand in hands)
        {
            var handScore = ScoreHand(hand);
            scoredHands.Add(handScore);
        }

        return scoredHands;
    }

    private static Tuple<HandScore, string> ScoreHand(string hand)
    {
        IEnumerable<Card> cards = hand.Split(" ").Select(c => new Card(c));

        Card[] cardsByRank = [.. cards.OrderBy(c => Card.ORDER_MAP.TryGetValue(c.rank, out var value) ? value : int.MaxValue)];
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

        var handScores = new Dictionary<PokerHands, Score>
        {
            {PokerHands.STRAIGHT_FLUSH,             (Score)Math.Pow(10, 11) },
            {PokerHands.FIVE_HIGH_STRAIGHT_FLUSH,   (Score)Math.Pow(10, 10) },
            {PokerHands.FOUR_OF_A_KIND,             (Score)Math.Pow(10, 8) },
            {PokerHands.FULL_HOUSE,                 (Score)Math.Pow(10, 7) },
            {PokerHands.FLUSH,                      (Score)Math.Pow(10, 6) },
            {PokerHands.STRAIGHT,                   (Score)Math.Pow(10, 5) },
            {PokerHands.FIVE_HIGH_STRAIGHT,         (Score)Math.Pow(10, 4) },
            {PokerHands.THREE_OF_A_KIND,            (Score)Math.Pow(10, 3) },
            {PokerHands.TWO_PAIR,                   (Score)Math.Pow(10, 2) },
            {PokerHands.ONE_PAIR,                   (Score)Math.Pow(10, 1) },
            {PokerHands.NONE,                       0 },
        };

        PokerHands hand = IdentifyHand(cards);
        var score = handScores[hand];

        switch (hand)
        {
            case PokerHands.STRAIGHT_FLUSH:
                var highestCard = Card.Ordinal(cards.First().rank);

                return score + highestCard;
            case PokerHands.FOUR_OF_A_KIND:
                var fourOfAKind = groupedRanks.Where(group => group.Count() == 4);
                var kicker = Card.Ordinal(groupedRanks.Where(group => group.Count() == 1).First().Key);

                return score * Card.Ordinal(fourOfAKind.First().Key) + kicker;
            case PokerHands.FULL_HOUSE:
                var tripletScore = Card.Ordinal(threeOfAKind.First().Key);
                var pairs = groupedRanks.Where(group => group.Count() == 2);
                var pairScore = Card.Ordinal(pairs.First().Key);

                return score * tripletScore + pairScore;
            case PokerHands.THREE_OF_A_KIND:
                return score * Card.Ordinal(threeOfAKind.First().Key);
            default:
                return score;
        }
    }

    private static PokerHands IdentifyHand(IEnumerable<Card> cards)
    {
        var ranks = cards.Select(c => c.rank);
        var groupedRanks = ranks.GroupBy(r => r);
        var pairs = groupedRanks.Where(group => group.Count() == 2);

        var isFlush = CheckForFlush(cards);
        var isThreeOfAKind = groupedRanks.Where(group => group.Count() == 3).Any();
        var isStraight = CheckForStraight(cards, ranks, groupedRanks);
        var isFiveHighStraight = CheckForFiveHighStraight(cards, ranks, groupedRanks);

        if (isFlush && isStraight)
        {
            return PokerHands.STRAIGHT_FLUSH;
        }

        if (isFlush && isFiveHighStraight)
        {
            return PokerHands.FIVE_HIGH_STRAIGHT_FLUSH;
        }

        if (groupedRanks.Where(group => group.Count() == 4).Any())
        {
            return PokerHands.FOUR_OF_A_KIND;
        }

        if (isThreeOfAKind && (pairs.Count() == 1))
        {
            return PokerHands.FULL_HOUSE;
        }

        if (isFlush)
        {
            return PokerHands.FLUSH;
        }

        if (isFiveHighStraight)
        {
            return PokerHands.FIVE_HIGH_STRAIGHT;
        }

        if (isStraight)
        {
            return PokerHands.STRAIGHT;
        }

        if (isThreeOfAKind)
        {
            return PokerHands.THREE_OF_A_KIND;
        }

        if (pairs.Count() == 2)
        {
            return PokerHands.TWO_PAIR;
        }

        if (pairs.Count() == 1)
        {
            return PokerHands.ONE_PAIR;
        }

        return PokerHands.NONE;
    }

    private static bool CheckForStraight(IEnumerable<Card> cards, IEnumerable<string> ranks, IEnumerable<IGrouping<string, string>> groupedRanks)
    {
        var lowestRank = Card.Ordinal(cards.Last().rank);
        var highestRank = Card.Ordinal(cards.First().rank);
        var isOnlyUniqueRanks = groupedRanks.Count() == ranks.Count();

        return isOnlyUniqueRanks && highestRank - lowestRank == 4;
    }
    private static bool CheckForFiveHighStraight(IEnumerable<Card> cards, IEnumerable<string> ranks, IEnumerable<IGrouping<string, string>> groupedRanks)
    {
        var lowestRank = Card.Ordinal(cards.Last().rank);
        var hasAce = cards.First().rank == "A";
        var secondHighestRank = Card.Ordinal(cards.ElementAt(1).rank);

        var isOnlyUniqueRanks = groupedRanks.Count() == ranks.Count();

        return isOnlyUniqueRanks && hasAce & (secondHighestRank - lowestRank == 3);
    }

    private static bool CheckForFlush(IEnumerable<Card> cards)
    {
        var suits = cards.Select(c => c.suit);
        var groupedSuits = suits.GroupBy(s => s);

        return groupedSuits.Count() == 1;
    }

    private static Score ScoreRanks(IEnumerable<Card> cards)
    {
        StringBuilder score = cards.Aggregate(new StringBuilder(), (sb, card) => sb.Append(Card.PaddedOrdinal(card.rank)));

        return ulong.Parse(score.ToString());
    }
}

internal enum PokerHands
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

public class Card(string card)
{
    private static readonly string[] RANKED_CARDS = ["A", "K", "Q", "J", "10", "9", "8", "7", "6", "5", "4", "3", "2"];
    public static readonly Dictionary<string, int> ORDER_MAP = RANKED_CARDS.Select((s, i) => new { String = s, Index = i }).ToDictionary(x => x.String, x => x.Index);


    public readonly string rank = card[..^1];
    public readonly string suit = card.Substring(card.Length - 1, 1);

    public static Score Ordinal(string rank) => rank switch
    {
        "A" => 14,
        "K" => 13,
        "Q" => 12,
        "J" => 11,
        _ => (Score)short.Parse(rank),
    };
    public override string ToString() => String.Format("{0}{1}", rank, suit);

    public static string PaddedOrdinal(string rank) => Card.Ordinal(rank).ToString().PadLeft(2, '0');
}