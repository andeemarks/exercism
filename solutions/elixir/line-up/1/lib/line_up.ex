defmodule LineUp do
  @doc """
  Formats a full ticket sentence for the given name and number, including
  the person's name, the ordinal form of the number, and fixed descriptive text.
  """
  @spec format(name :: String.t(), number :: pos_integer()) :: String.t()
  def format(name, number) do
    last_two_digits = number |> Integer.digits() |> Enum.take(-2) |> Integer.undigits()
    "#{name}, you are the #{number}#{suffix(last_two_digits)} customer we serve today. Thank you!"
  end

  # def suffix(number) when not (number in [11, 12, 13]) do
  #   suffix(rem(number, 10))
  # end

  def suffix(number) when number < 10 do
    case number do
      1 -> "st"
      2 -> "nd"
      3 -> "rd"
      _ -> "th"
    end
  end

  def suffix(number) when number >= 10 do
    case number do
      21 -> "st"
      31 -> "st"
      41 -> "st"
      51 -> "st"
      61 -> "st"
      71 -> "st"
      81 -> "st"
      91 -> "st"
      22 -> "nd"
      32 -> "nd"
      42 -> "nd"
      52 -> "nd"
      62 -> "nd"
      72 -> "nd"
      82 -> "nd"
      92 -> "nd"
      23 -> "rd"
      33 -> "rd"
      43 -> "rd"
      53 -> "rd"
      63 -> "rd"
      73 -> "rd"
      83 -> "rd"
      93 -> "rd"
      _ -> "th"
    end
  end
end
