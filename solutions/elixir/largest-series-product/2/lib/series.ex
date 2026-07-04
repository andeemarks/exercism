defmodule Series do
  @doc """
  Finds the largest product of a given number of consecutive numbers in a given string of numbers.
  """
  @spec largest_product(String.t(), non_neg_integer) :: non_neg_integer
  def largest_product(number_string, size) do
    number_string
    |> String.graphemes()
    |> Enum.map(&String.to_integer/1)
    |> largest_product2(size)
  end

  defp largest_product2(digits, size) when length(digits) < size, do: raise ArgumentError
  defp largest_product2(_, size) when size <= 0, do: raise ArgumentError

  defp largest_product2(digits, size) do
    spans = digits
    |> Enum.chunk_every(size, 1, :discard)

    spans
    |> Enum.map(&product_of_digits/1) |> Enum.max()
  end

  defp product_of_digits(digits), do: Enum.reduce(digits, 1, fn(x, acc) -> x * acc end)
end
