defmodule IsbnVerifier do
  @doc """
    Checks if a string is a valid ISBN-10 identifier

    ## Examples

      iex> IsbnVerifier.isbn?("3-598-21507-X")
      true

      iex> IsbnVerifier.isbn?("3-598-2K507-0")
      false

  """
  @spec isbn?(String.t()) :: boolean
  def isbn?(isbn) do
    [check | digits] = components(isbn)

    validate_isbn(digits, check_value(check))
  end

  defp components(isbn) do
    isbn
    |> String.replace(~r/[\-]/, "")
    |> String.codepoints()
    |> Enum.reverse()
  end

  defp check_value("X"), do: 10
  defp check_value(digit), do: digit_value(digit)

  defp validate_isbn(digits, _) when length(digits) != 9, do: false
  defp validate_isbn(digits, check_value) do
    sum = digits
    |> Enum.with_index(2)
    |> Enum.reduce(0, fn {digit, index}, acc ->
      acc + digit_value(digit) * index
    end)
    |> Kernel.+(check_value)

    rem(sum, 11) == 0
  end

  defp digit_value(digit) do
    case Integer.parse(digit) do
      {value, _} -> value
      :error -> 12
    end
  end
end
