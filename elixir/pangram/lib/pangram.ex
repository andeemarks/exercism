defmodule Pangram do
  @unique_letters MapSet.new(String.split("ABCDEFGHIJKLMNOPQRSTUVWXYZ", "", trim: true))

  @doc """
  Determines if a word or sentence is a pangram.
  A pangram is a sentence using every letter of the alphabet at least once.

  Returns a boolean.

    ## Examples

      iex> Pangram.pangram?("the quick brown fox jumps over the lazy dog")
      true

  """
  
  @spec pangram?(String.t()) :: boolean
  def pangram?(sentence) do
    sentence_letters = sentence
    |> String.upcase()
    |> String.split("")
    |> Enum.filter(fn letter -> String.match?(letter, ~r/^[ABCDEFGHIJKLMNOPQRSTUVWXYZ]$/) end)
    |> MapSet.new

    sentence_letters == @unique_letters
  end
end
