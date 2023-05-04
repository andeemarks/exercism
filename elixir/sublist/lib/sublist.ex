defmodule Sublist do
  @doc """
  Returns whether the first list is a sublist or a superlist of the second list
  and if not whether it is equal or unequal to the second list.
  """
  def compare(a, a), do: :equal

  def compare([], _), do: :sublist

  def compare(_, []), do: :superlist

  def compare(a, b) when length(a) == length(b) do
    if contains(a, b), do: :equal, else: :unequal
  end

  def compare(a, b) when length(a) < length(b) do
    if contains(a, b), do: :sublist, else: :unequal
  end

  def compare(a, b) when length(a) > length(b) do
    if contains(b, a), do: :superlist, else: :unequal
  end

  defp contains(list_a, list_b) do
    list_b
    |> Enum.chunk_every(length(list_a), 1)
    |> Enum.map(fn sublist -> sublist === list_a end)
    |> Enum.any?()
  end
end
