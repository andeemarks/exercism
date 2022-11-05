defmodule Scrabble do
  @doc """
  Calculate the scrabble score for the word.
  """
  @spec score(String.t()) :: non_neg_integer
  def score(word) do
    word
    |> String.split("", trim: true)
    |> Enum.map(fn l -> score_letter(String.upcase(l)) end)
    |> Enum.sum()
  end

  defp score_letter(letter) when letter in ["A", "E", "I", "O", "U", "L", "R", "N", "S", "T"], do: 1
  defp score_letter(letter) when letter in ["F", "H", "V", "W", "Y"], do: 4
  defp score_letter(letter) when letter in ["D", "G"], do: 2
  defp score_letter(letter) when letter in ["B", "C", "M", "P"], do: 3
  defp score_letter(letter) when letter in ["K"], do: 5
  defp score_letter(letter) when letter in ["J", "X"], do: 8
  defp score_letter(letter) when letter in ["Z", "Q"], do: 10
  defp score_letter(_), do: 0
end
