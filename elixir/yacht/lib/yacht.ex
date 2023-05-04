defmodule Yacht do
  @type category ::
          :ones
          | :twos
          | :threes
          | :fours
          | :fives
          | :sixes
          | :full_house
          | :four_of_a_kind
          | :little_straight
          | :big_straight
          | :choice
          | :yacht

  @doc """
  Calculate the score of 5 dice using the given category's scoring method.
  """
  @spec score(category :: category(), dice :: [integer]) :: integer
  def score(category, dice) do
    unique_roll_count = length(Enum.uniq(dice))
    roll_groupings = dice |> Enum.frequencies() |> Map.values() |> Enum.sort()
    sorted_rolls = dice |> Enum.sort()

    case category do
      :yacht when unique_roll_count == 1 -> 50
      :yacht -> 0
      :ones -> n_points_for_each_n_roll(1, dice)
      :twos -> n_points_for_each_n_roll(2, dice)
      :threes -> n_points_for_each_n_roll(3, dice)
      :fours -> n_points_for_each_n_roll(4, dice)
      :fives -> n_points_for_each_n_roll(5, dice)
      :sixes -> n_points_for_each_n_roll(6, dice)
      :full_house when roll_groupings == [2, 3] -> Enum.sum(dice)
      :full_house -> 0
      :four_of_a_kind when roll_groupings == [1, 4] -> 4 * four_of_a_kind_dice(dice)
      :four_of_a_kind when unique_roll_count == 1 -> dice |> Enum.take(4) |> Enum.sum()
      :four_of_a_kind -> 0
      :little_straight when sorted_rolls == [1, 2, 3, 4, 5] -> 30
      :little_straight -> 0
      :big_straight when sorted_rolls == [2, 3, 4, 5, 6] -> 30
      :big_straight -> 0
      :choice -> Enum.sum(dice)
    end
  end

  @spec four_of_a_kind_dice(dice :: [integer]) :: integer
  defp four_of_a_kind_dice(dice) do
    Map.reject(Enum.frequencies(dice), fn {_k, v} -> v == 1 end) |> Map.keys() |> hd
  end

  @spec n_points_for_each_n_roll(n :: integer, dice :: [integer]) :: integer
  defp n_points_for_each_n_roll(n, dice),
    do: n * length(Enum.filter(dice, fn roll -> roll == n end))
end
