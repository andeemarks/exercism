defmodule BinarySearch do
  @doc """
    Searches for a key in the tuple using the binary search algorithm.
    It returns :not_found if the key is not in the tuple.
    Otherwise returns {:ok, index}.

    ## Examples

      iex> BinarySearch.search({}, 2)
      :not_found

      iex> BinarySearch.search({1, 3, 5}, 2)
      :not_found

      iex> BinarySearch.search({1, 3, 5}, 5)
      {:ok, 2}

  """

  @spec search(tuple, integer) :: {:ok, integer} | :not_found
  def search(numbers, key), do: binary_search(numbers, key)

  defp binary_search({}, _), do: :not_found
  defp binary_search(numbers, key), do: binary_search(numbers, key, 0, tuple_size(numbers) - 1)
  
  defp binary_search(numbers, key, lower, upper) do
    split_point = Integer.floor_div(upper - lower, 2) + lower
    split_value = elem(numbers, split_point)
    cond do
      split_value == key -> {:ok, split_point}
      lower == upper -> :not_found
      split_value > key -> binary_search(numbers, key, lower, split_point)
      split_value < key -> binary_search(numbers, key, split_point + 1, upper)
    end
  end
end
