defmodule Say do
  @words %{
    0 => "zero",
    1 => "one",
    2 => "two",
    3 => "three",
    4 => "four",
    5 => "five",
    6 => "six",
    7 => "seven",
    8 => "eight",
    9 => "nine",
    10 => "ten",
    11 => "eleven",
    12 => "twelve",
    13 => "thirteen",
    14 => "fourteen",
    15 => "fifteen",
    16 => "sixteen",
    17 => "seventeen",
    18 => "eighteen",
    19 => "nineteen",
    20 => "twenty",
    30 => "thirty",
    40 => "forty",
    50 => "fifty",
    60 => "sixty",
    70 => "seventy",
    80 => "eighty",
    90 => "ninety"
  }

  @billions 1_000_000_000
  @millions 1_000_000
  @thousands 1_000
  @hundreds 100

  defguardp is_even_ten(number)
            when is_integer(number) and number in 10..90 and rem(number, 10) == 0

  defguardp is_even_hundred(number)
            when is_integer(number) and number in @hundreds..900 and rem(number, @hundreds) == 0

  defguardp is_even_million(number)
            when is_integer(number) and number in @millions..900_000_000 and
                   rem(number, @millions) == 0

  defguardp is_even_billion(number)
            when is_integer(number) and number in @billions..900_000_000_000 and
                   rem(number, @billions) == 0

  defguardp is_even_thousand(number)
            when is_integer(number) and number in @thousands..9000 and
                   rem(number, @thousands) == 0

  @doc """
  Translate a positive integer into English.
  """
  @spec in_english(integer) :: {atom, String.t()}

  def in_english(number) when number not in 0..999_999_999_999 do
    {:error, "number is out of range"}
  end

  def in_english(number), do: {:ok, say(number)}

  defp number_of_unit(number, unit), do: trunc(number / unit)

  defp lookup(number), do: Map.get(@words, number, number)

  defp say(number) when is_even_billion(number) do
    billions = number_of_unit(number, @billions)

    "#{say(billions)} billion"
  end

  defp say(number) when number >= @billions do
    billions = number_of_unit(number, @billions)

    "#{say(billions)} billion #{say(number - billions * @billions)}"
  end

  defp say(number) when is_even_million(number) do
    millions = number_of_unit(number, @millions)

    "#{say(millions)} million"
  end

  defp say(number) when number >= @millions do
    millions = number_of_unit(number, @millions)

    "#{say(millions)} million #{say(number - millions * @millions)}"
  end

  defp say(number) when number > @thousands do
    thousands = number_of_unit(number, @thousands)

    "#{say(thousands)} thousand #{say(number - thousands * @thousands)}"
  end

  defp say(number) when is_even_thousand(number) do
    thousands = number_of_unit(number, @thousands)

    "#{say(thousands)} thousand"
  end

  defp say(number) when is_even_hundred(number) do
    hundreds = number_of_unit(number, @hundreds)

    "#{say(hundreds)} hundred"
  end

  defp say(number) when number > @hundreds do
    hundreds = number_of_unit(number, @hundreds)

    "#{say(hundreds)} hundred #{say(number - hundreds * @hundreds)}"
  end

  defp say(number) when number in 0..19, do: lookup(number)
  defp say(number) when is_even_ten(number), do: lookup(number)

  defp say(number) when number > 20 do
    tens = number_of_unit(number, 10)

    "#{say(tens * 10)}-#{say(number - tens * 10)}"
  end
end
