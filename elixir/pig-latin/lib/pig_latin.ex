defmodule PigLatin do
  @doc """
  Given a `phrase`, translate it a word at a time to Pig Latin.
  """
  @spec translate(phrase :: String.t()) :: String.t()
  def translate(phrase) do
    phrase
    |> String.split
    |> Enum.map(&translate_word/1)
    |> Enum.join(" ")
  end

  defp translate_word(word) do
    y_two_letter_word = Regex.named_captures(~r/(?<prefix>^.)(?<suffix>y)/, word)
    y_after_consonants_word = Regex.named_captures(~r/(?<prefix>^[b-df-hj-np-tv-z]+)y(?<suffix>.*)/, word)
    leading_xy_word = Regex.named_captures(~r/(?<prefix>^[xy][b-df-hj-np-tv-z]+)(?<suffix>.*)/, word)
    leading_qu_word = Regex.named_captures(~r/(?<prefix>^qu)(?<suffix>.*)/, word)
    embedded_qu_word = Regex.named_captures(~r/(?<prefix>^[b-df-hj-np-tv-z]qu)(?<suffix>.*)/, word)
    consonant_word = Regex.named_captures(~r/(?<prefix>^[b-df-hj-np-tv-z]+)(?<suffix>.*)/, word)
    cond do
      y_two_letter_word != nil -> assemble(y_two_letter_word)
      y_after_consonants_word != nil -> "y" <> assemble(y_after_consonants_word)
      leading_xy_word != nil -> assemble(word)
      embedded_qu_word != nil -> assemble(embedded_qu_word)
      leading_qu_word != nil -> assemble(leading_qu_word)
      consonant_word != nil -> assemble(consonant_word)
      true -> suffix(word)
    end
    
  end

  defp assemble(%{"prefix" => prefix, "suffix" => suffix}), do: suffix(suffix <> prefix)
  defp assemble(word), do: suffix(word)
  defp suffix(word), do: "#{word}ay"
end
