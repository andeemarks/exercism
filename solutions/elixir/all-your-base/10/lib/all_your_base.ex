defmodule AllYourBase do
  @doc """
  Given a number in input base, represented as a sequence of digits, converts it to output base,
  or returns an error tuple if either of the bases are less than 2
  """

  @spec convert(list, integer, integer) :: {:ok, list} | {:error, String.t()}
  def convert(_, input_base, _) when input_base < 2, do: {:error, "input base must be >= 2"}
  def convert(_, _, output_base) when output_base < 2, do: {:error, "output base must be >= 2"}
  def convert(digits, input_base, output_base) do
    if (Enum.any?(digits, &(&1 < 0 or &1 >= input_base))) do
      {:error, "all digits must be >= 0 and < input base"}
    else
      {:ok, do_convert(digits, input_base, output_base)}
    end
  end

  defp do_convert(digits, input_base, output_base) do
    digits
    |> to_base_10(input_base)
    |> from_base_10(output_base)
  end

  defp to_base_10(digits, input_base) do
    digits
    |> Enum.reverse()
    |> Enum.with_index()
    |> Enum.reduce(0, fn {digit, index}, acc -> acc + digit * Integer.pow(input_base, index)
    end)
  end

  defp from_base_10(0, _), do: [0]
  defp from_base_10(digits, 10), do: Integer.digits(digits)
  defp from_base_10(digits, output_base) when output_base >= 2 and output_base <= 36 do
    digits
    |> Integer.to_string(output_base)
    |> String.graphemes()
    |> Enum.map(fn d -> Integer.parse(d, output_base) |> elem(0) end)
  end

  defp from_base_10(digits, output_base) do
    powers = 0..100
    |> Stream.map(&Integer.pow(output_base, &1))
    |> Stream.filter(fn power -> power <= digits end)
    |> Enum.reverse()

    digits
    |> do_from_base_10(powers)
  end

  defp do_from_base_10(digits, powers) do
    case powers do
      [] -> []
      [power | rest] ->
        digit = div(digits, power)
        [digit | do_from_base_10(digits - digit * power, rest)]
    end
  end
end
