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

  defp digit_span_products(digits, span_size) when length(digits) < span_size, do: raise ArgumentError
  defp digit_span_products(_, span_size) when span_size <= 0, do: raise ArgumentError

  defp digit_span_products(digits, span_size) do
    digits
    |> Enum.chunk_every(span_size, 1, :discard)
    |> Enum.map(&product_of_digits/1)
  end

  defp product_of_digits(digits), do: Enum.reduce(digits, 1, &*/2)
end
