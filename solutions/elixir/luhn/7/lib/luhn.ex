defmodule Luhn do
  @doc """
  Checks if the given number is valid via the luhn formula
  """
  @spec valid?(String.t()) :: boolean
  def valid?(number) do
    chars = String.replace(number, ~r/\s+/, "")
    digits = String.replace(number, ~r/\D/, "")
    |> String.codepoints()
    |> Enum.map(&String.to_integer/1)

    if String.length(chars) != length(digits) do
      false
    else
      validate_digits(digits)
    end
  end

  defp validate_digits(digits) when length(digits) <= 1, do: false
  defp validate_digits(digits) when length(digits) == 16, do: validate_digits(digits, &cc_mapper/2)
  defp validate_digits(digits), do: validate_digits(digits, &sin_mapper/2)
  defp validate_digits(digits, mapper) do
    digits
    |> Enum.reverse()
    |> Enum.with_index()
    |> Enum.map(fn {n, i} ->
      mapper.(n, i)
    end)
    |> Enum.sum()
    |> rem(10) == 0
  end

  defp cc_mapper(digit, index) do
    if rem(index, 2) == 1 do
      digit
    else
      digit * 2
    end
  end

  defp sin_mapper(digit, index) do
    if rem(index, 2) == 0 do
      digit
    else
      if digit * 2 > 9 do
        digit * 2 - 9
      else
        digit * 2
      end
    end
  end
end
