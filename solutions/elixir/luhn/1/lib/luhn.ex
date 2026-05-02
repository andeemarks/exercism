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

  defp validate_digits(digits) when length(digits) <= 1 do
    false
  end
  defp validate_digits(digits) when length(digits) == 16 do
    digits
    |> Enum.reverse()
    |> Enum.with_index()
    |> Enum.map(fn {n, i} ->
      if rem(i, 2) == 1 do
        n
      else
        n * 2
      end
    end)
    |> Enum.sum()
    |> rem(10) == 0
  end
  defp validate_digits(digits) do
    digits
    |> Enum.reverse()
    |> Enum.with_index()
    |> Enum.map(fn {n, i} ->
      if rem(i, 2) == 0 do
        n
      else
        if n * 2 > 9 do
          n * 2 - 9
        else
          n * 2
        end
      end
    end)
    |> Enum.sum()
    |> rem(10) == 0
  end
end
