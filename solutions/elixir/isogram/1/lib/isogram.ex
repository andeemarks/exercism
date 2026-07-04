defmodule Isogram do
  @doc """
  Determines if a word or sentence is an isogram
  """
  @spec isogram?(String.t()) :: boolean
  def isogram?(sentence) do

    sentence_chars = String.replace(sentence, ~r/[^a-zA-Z]/, "")

    sentence_chars |> String.downcase() |> String.to_charlist() |> MapSet.new() |> MapSet.size() == String.length(sentence_chars)
  end
end
