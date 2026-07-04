defmodule Series do
  @doc """
  Finds the largest product of a given number of consecutive numbers in a given string of numbers.
  """
  @spec largest_product(String.t(), non_neg_integer) :: non_neg_integer
  def largest_product(number_string, size) do
    number_string
    |> to_digits()
    |> digit_span_products(size)
    |> Enum.max()
  end

  defp to_digits(number_string) do
    number_string
    |> String.graphemes()
    |> Enum.map(&String.to_integer/1)
  end

  defp digit_span_products(digits, size) when length(digits) < size, do: raise ArgumentError
  defp digit_span_products(_, size) when size <= 0, do: raise ArgumentError

  defp digit_span_products(digits, size) do
    digits
    |> Enum.chunk_every(size, 1, :discard)
    |> Enum.map(&product_of_digits/1)
  end

  defp product_of_digits(digits), do: Enum.reduce(digits, 1, &*/2)
end
