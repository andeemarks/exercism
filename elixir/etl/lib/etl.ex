defmodule ETL do
  @doc """
  Transforms an old Scrabble score system to a new one.

  ## Examples

    iex> ETL.transform(%{1 => ["A", "E"], 2 => ["D", "G"]})
    %{"a" => 1, "d" => 2, "e" => 1, "g" => 2}
  """
  @spec transform(map) :: map
  def transform(input) do
    Enum.reduce(input, %{}, fn {score, letters}, result -> transform(score, letters, result) end)
  end

  defp transform(score, letters, result) do
    Enum.reduce(letters, result, fn letter, result -> Map.put(result, String.downcase(letter), score) end)
  end
end
