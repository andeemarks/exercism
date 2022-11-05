defmodule WordCount do
  @doc """
  Count the number of words in the sentence.

  Words are compared case-insensitively.
  """
  @spec count(String.t()) :: map
  def count(sentence) do
    sentence
    |> break_into_words()
    |> remove_punctuation()
    |> remove_single_quotes()
    |> count_words()
  end

  defp count_words(words), do: Enum.frequencies_by(words, &String.downcase/1)

  defp break_into_words(sentence) do
    String.split(sentence, [" ", ",", "_", ".", ":", "\n"], trim: true)
  end

  defp remove_punctuation(words) do
    words
    |> Enum.map(&String.replace(&1, ~r/[!#$%&()*+,.:;<=>?@\^_`{|}~]/, ""))
  end

  defp remove_single_quotes(words) do
    words
    |> Enum.map(&String.trim_leading(&1, "'"))
    |> Enum.map(&String.trim_trailing(&1, "'"))
  end
end
