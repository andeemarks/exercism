defmodule RomanNumerals do
  @doc """
  Convert the number to a roman number.
  """
  @spec numeral(pos_integer) :: String.t()
  def numeral(0), do: ""
  def numeral(1), do: "I"
  def numeral(2), do: "II"
  def numeral(3), do: "III"
  def numeral(4), do: "IV"
  def numeral(5), do: "V"
  def numeral(number) when number >= 1000 do
    thousands = div(number, 1000)
    _duplicate("M", thousands) <> numeral(rem(number, 1000))
  end
  def numeral(number) when number >= 100 do
    hundreds = div(number, 100)
    cond do
      hundreds < 4 -> _duplicate("C", hundreds) <> numeral(rem(number, 100))
      hundreds == 4 -> "CD" <> numeral(rem(number, 100))
      hundreds == 9 -> "CM" <> numeral(rem(number, 100))
      true -> "D" <> _duplicate("C", hundreds - 5) <> numeral(rem(number, 100))
    end
  end
  def numeral(number) when number >= 10 do
    tens = div(number, 10)
    cond do
      tens < 4 -> _duplicate("X", tens) <> numeral(rem(number, 10))
      tens == 4 -> "XL" <> numeral(rem(number, 10))
      tens == 9 -> "XC" <> numeral(rem(number, 10))
      true -> "L" <> _duplicate("X", tens - 5) <> numeral(rem(number, 10))
    end
  end
  def numeral(number) when number < 10 do
    ones = number - 5
    cond do
      ones < 4 -> numeral(5) <> _duplicate("I", ones)
      true -> "IX"
    end
  end

  defp _duplicate(char, count), do: List.duplicate(char, count) |> Enum.join()
end
