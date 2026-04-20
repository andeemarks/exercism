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
      n when n in [21, 31, 41, 51, 61, 71, 81, 91] -> "st"
      n when n in [22, 32, 42, 52, 62, 72, 82, 92] -> "nd"
      n when n in [23, 33, 43, 53, 63, 73, 83, 93] -> "rd"
      _ -> "th"
    end
  end
end
