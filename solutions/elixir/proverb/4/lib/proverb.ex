defmodule Proverb do
  @doc """
  Generate a proverb from a list of strings.
  """
  @spec recite(strings :: [String.t()]) :: String.t()
  def recite([]), do: ""
  def recite(strings = [head | _]) do
    last = List.last(strings)
    _recite(strings)
    |> String.replace("for the want of a #{last}", "for the want of a #{head}")
  end
  defp _recite(strings = [head | tail]) when length(strings) > 1 do
    "For want of a #{head} the #{List.first(tail)} was lost.\n" <>
      _recite(tail)
  end
  defp _recite(strings) when length(strings) == 1 do
    "And all for the want of a #{List.first(strings)}.\n"
  end
end
