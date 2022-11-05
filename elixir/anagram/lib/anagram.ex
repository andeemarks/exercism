defmodule Anagram do
  @doc """
  Returns all candidates that are anagrams of, but not equal to, 'base'.
  """
  @spec match(String.t(), [String.t()]) :: [String.t()]
  def match(base, candidates) do
    base_letters =
      base
      |> String.upcase()
      |> String.to_charlist()
      |> Enum.sort()

    remaining_candidates = Enum.filter(candidates, &(not same_word?(base, &1)))

    Enum.filter(remaining_candidates, &same_letters?(base_letters, &1))
  end

  defp same_word?(word1, word2) do
    String.upcase(word1) == String.upcase(word2)
  end

  defp same_letters?(letters, word) do
    letters == Enum.sort(String.to_charlist(String.upcase(word)))
  end
end
