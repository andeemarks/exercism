defmodule SumOfMultiples do
  @doc """
  Adds up all numbers from 1 to a given end number that are multiples of the factors provided.
  """
  @spec to(non_neg_integer, [non_neg_integer]) :: non_neg_integer
  def to(limit, factors) do
    factors
    |> Enum.reduce([], fn number, acc -> acc ++ factors_to(number, limit) end)
    |> MapSet.new()
    |> Enum.sum()
  end

  defp factors_to(0, _), do: [0]
  defp factors_to(start, limit), do: Enum.to_list(start..limit-1//start)
end
