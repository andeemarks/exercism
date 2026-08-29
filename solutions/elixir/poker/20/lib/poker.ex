defmodule Poker do
  @doc """
  Given a list of poker hands, return a list containing the highest scoring hand.

  If two or more hands tie, return the list of tied hands in the order they were received.

  The basic rules and hand rankings for Poker can be found at:

  https://en.wikipedia.org/wiki/List_of_poker_hands

  For this exercise, we'll consider the game to be using no Jokers,
  so five-of-a-kind hands will not be tested. We will also consider
  the game to be using multiple decks, so it is possible for multiple
  players to have identical cards.

  Aces can be used in low (A 2 3 4 5) or high (10 J Q K A) straights, but do not count as
  a high card in the former case.

  For example, (A 2 3 4 5) will lose to (2 3 4 5 6).

  You can also assume all inputs will be valid, and do not need to perform error checking
  when parsing card values. All hands will be a list of 5 strings, containing a number
  (or letter) for the rank, followed by the suit.

  Ranks (lowest to highest): 2 3 4 5 6 7 8 9 10 J Q K A
  Suits (order doesn't matter): C D H S

  Example hand: ~w(4S 5H 4C 5D 4H) # Full house, 5s over 4s
  """
  @spec best_hand(list(list(String.t()))) :: list(list(String.t()))
  def best_hand(hands) when length(hands) == 1, do: hands
  def best_hand(hands) do
    sorted_hands = hands |> Enum.group_by(&hand_score/1)

    highest_score = sorted_hands |> Map.keys() |> Enum.max()

    Map.get(sorted_hands, highest_score)
  end

  defp hand_score(hand) do
    cond do
      straight?(hand) and flush?(hand) -> {8, highest_ranked_card(hand), score_highest_value_hand(hand)}
      aces_low_straight?(hand) and flush?(hand) -> {7.5, highest_ranked_card(hand), score_highest_value_hand(hand)}
      four_of_a_kind?(hand) -> {7, highest_ranked_quad(hand), score_highest_value_hand(hand)}
      full_house?(hand) -> {6, highest_ranked_triplet(hand), score_highest_value_hand(hand)}
      flush?(hand) -> {5, score_highest_value_hand(hand), score_highest_value_hand(hand)}
      straight?(hand) -> {4, highest_ranked_card(hand), score_highest_value_hand(hand)}
      aces_low_straight?(hand) -> {3.5, highest_ranked_card(hand), score_highest_value_hand(hand)}
      three_of_a_kind?(hand) -> {3, highest_ranked_triplet(hand), score_highest_value_hand(hand)}
      two_pair?(hand) -> {2, highest_ranked_pair(hand), score_highest_value_hand(hand)}
      one_pair?(hand) -> {1, pair_value(hand), score_highest_value_hand(hand)}
      true -> {0, score_highest_value_hand(hand)}
    end
  end

  defp highest_ranked_quad(hand), do: highest_ranked_multiple(hand, 4)
  defp highest_ranked_triplet(hand), do: highest_ranked_multiple(hand, 3)
  defp highest_ranked_pair(hand), do: highest_ranked_multiple(hand, 2)
  defp highest_ranked_multiple(hand, multiple) do
    hand
    |> multiples()
    |> Enum.filter(fn {_rank, count} -> count == multiple end)
    |> Enum.map(fn {rank, _count} -> rank_value(rank) end)
    |> Enum.max()
  end

  defp highest_ranked_card(hand) do
    hand
    |> ranks()
    |> Enum.map(&rank_value/1)
    |> Enum.max()
  end

  defp score_highest_value_hand(hand) do
    score = hand
    |> ranks()
    |> Enum.map(&rank_value/1) # convert ranks to their integer values
    |> Enum.sort(:desc) # sort the values in descending order
    |> Enum.map(&Integer.to_string/1) # convert the integer values back to strings
    |> Enum.map(fn d -> String.pad_leading(d, 2, "0") end) # pad single digit values with a leading zero for proper string comparison
    |> Enum.join() # join the values into a single string

    ("0." <> score) |> String.to_float() # convert the string to a float for comparison
  end

  defp suits(hand), do: hand |> Enum.map(&String.last/1)
  defp ranks(hand), do: hand |> Enum.map(&String.slice(&1, 0..-2//1))
  defp flush?(hand), do: suits(hand) |> Enum.frequencies() |> Enum.any?(fn {_suit, count} -> count == 5 end)
  defp straight?(hand) do
    card_values = ranks(hand) |> Enum.map(&rank_value/1)
    highest_value = card_values |> Enum.max()
    lowest_value = card_values |> Enum.min()
    unique_card_values? = sorted_multiples(hand) == [1, 1, 1, 1, 1]

    unique_card_values? and (highest_value - lowest_value == 4)
  end
  defp aces_low_straight?(hand) do
    card_values = ranks(hand) |> Enum.map(&rank_value/1)

    Enum.sort(card_values) == [2, 3, 4, 5, 14]
  end
  defp full_house?(hand), do: sorted_multiples(hand) == [2, 3]
  defp two_pair?(hand), do: sorted_multiples(hand) == [1, 2, 2]
  defp one_pair?(hand), do: sorted_multiples(hand) == [1, 1, 1, 2]
  defp four_of_a_kind?(hand), do: sorted_multiples(hand) == [1, 4]
  defp three_of_a_kind?(hand), do: sorted_multiples(hand) == [1, 1, 3]
  defp multiples(hand), do: ranks(hand) |> Enum.frequencies()
  defp sorted_multiples(hand), do: multiples(hand) |> Map.values() |> Enum.sort()
  defp pair_value(hand) do
    multiples(hand)
    |> Enum.find(fn {_rank, count} -> count == 2 end)
    |> elem(0)
    |> rank_value()
  end
  defp rank_value("J"), do: 11
  defp rank_value("Q"), do: 12
  defp rank_value("K"), do: 13
  defp rank_value("A"), do: 14
  defp rank_value(rank), do: String.to_integer(rank)
end
