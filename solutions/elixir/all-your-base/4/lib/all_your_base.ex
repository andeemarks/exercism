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
      digits_in_base_10 = to_base_10(digits, input_base)
      digits_from_base_10 = base_10_to_output_base(digits_in_base_10, output_base)
      {:ok, digits_from_base_10}
    end
  end

  defp to_base_10(digits, input_base) do
    digits
    |> Enum.reverse()
    |> Enum.with_index()
    |> Enum.reduce(0, fn {digit, index}, acc ->
      trunc(acc + digit * :math.pow(input_base, index))
    end)
    |> Integer.digits()
    |> Enum.join()
    |> String.to_integer()
  end

  defp base_10_to_output_base(0, _), do: [0]
  defp base_10_to_output_base(digits, 10), do: Integer.digits(digits)
  defp base_10_to_output_base(digits, output_base) when output_base >= 2 and output_base <= 36 do
    digits
    |> Integer.to_string(output_base)
    |> String.graphemes()
    |> Enum.map(fn d -> Integer.parse(d, output_base) |> elem(0) end)
  end

  defp base_10_to_output_base(digits, output_base) do
    powers = 0..100
    |> Stream.map(&Integer.pow(output_base, &1))
    |> Stream.filter(fn power -> power <= digits end)
    |> Enum.reverse()

    digits
    |> do_base_10_to_output_base(powers)
  end

  defp do_base_10_to_output_base(digits, powers) do
    case powers do
      [] -> []
      [power | rest] ->
        digit = div(digits, power)
        [digit | do_base_10_to_output_base(digits - digit * power, rest)]
    end
  end
end
