defmodule RnaTranscription do
  @transcriptions %{?G => "C", ?C => "G", ?T => "A", ?A => "U"}

  @doc """
  Transcribes a character list representing DNA nucleotides to RNA

  ## Examples

  iex> RnaTranscription.to_rna('ACTG')
  'UGAC'
  """
  @spec to_rna([char]) :: [char]
  def to_rna(dna) do
    dna
    |> Enum.map(&to_rna_char/1)
    |> Enum.join
    |> String.to_charlist
  end

  defp to_rna_char(char) do
      Map.get(@transcriptions, char, char)
  end
end
