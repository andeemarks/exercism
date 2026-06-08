defmodule BottleSong do
  @moduledoc """
  Handles lyrics of the popular children song: Ten Green Bottles
  """

    @numbers %{
      0 => "no",
      1 => "one",
      2 => "two",
      3 => "three",
      4 => "four",
      5 => "five",
      6 => "six",
      7 => "seven",
      8 => "eight",
      9 => "nine",
      10 => "ten"
    }

  @spec recite(pos_integer, pos_integer) :: String.t()
  def recite(start_bottle, 1) do
    """
               #{String.capitalize(@numbers[start_bottle])} green bottle#{if start_bottle == 1, do: "", else: "s"} hanging on the wall,
               #{String.capitalize(@numbers[start_bottle])} green bottle#{if start_bottle == 1, do: "", else: "s"} hanging on the wall,
               And if one green bottle should accidentally fall,
               There'll be #{@numbers[start_bottle - 1]} green bottle#{if start_bottle - 1 == 1, do: "", else: "s"} hanging on the wall.\
               """
  end
  def recite(start_bottle, take_down) do
    recite(start_bottle, 1) <> "\n\n" <> recite(start_bottle - 1, take_down - 1)
  end
end
