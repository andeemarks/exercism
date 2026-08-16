defmodule House do

  @actors [
    ["the malt", "lay"],
    ["the rat", "ate"],
    ["the cat", "killed"],
    ["the dog", "worried"],
    ["the cow with the crumpled horn", "tossed"],
    ["the maiden all forlorn", "milked"],
    ["the man all tattered and torn", "kissed"],
    ["the priest all shaven and shorn", "married"],
    ["the rooster that crowed in the morn", "woke"],
    ["the farmer sowing his corn", "kept"],
    ["the horse and the hound and the horn", "belonged to"]
  ]

@doc """
  Return verses of the nursery rhyme 'This is the House that Jack Built'.
  """

  @spec recite(start :: integer, stop :: integer) :: String.t()
  def recite(1, 1) do
    "This is the house that Jack built.\n"
  end
  def recite(start, stop) when start === stop do
    "This is " <> build_line(start) <> "in the house that Jack built.\n"
  end
  def recite(start, stop) do
    Enum.map(start..stop, fn n -> recite(n, n) end)
    |> Enum.join()
  end

  defp build_line(n) when n > 1 do
    [actor, action] = Enum.at(@actors, n - 2)
    "#{actor} that #{action} #{build_line(n - 1)}"
  end
  defp build_line(1) do
    ""
  end
end
