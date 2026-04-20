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

  def suffix(number) do
    digits = number |> Integer.digits()
    last_digit = digits |> Enum.take(-1) |> Integer.undigits()
    second_last_digit = digits |> Enum.take(-2) |> Enum.drop(-1) |> Integer.undigits()
    case {last_digit, second_last_digit} do
      {1, 1} -> "th"
      {1, _} -> "st"
      {2, 1} -> "th"
      {2, _} -> "nd"
      {3, 1} -> "th"
      {3, _} -> "rd"
      _ -> "th"
    end
  end
end
