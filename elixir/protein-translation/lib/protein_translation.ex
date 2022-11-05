defmodule ProteinTranslation do

  @invalid_rna :error

  defp translate!(codon) when codon in ["UGU", "UGC"], do: "Cysteine"
  defp translate!(codon) when codon in ["UUA", "UUG"], do: "Leucine"
  defp translate!(codon) when codon in ["AUG"], do: "Methionine"
  defp translate!(codon) when codon in ["UUU", "UUC"], do: "Phenylalanine"
  defp translate!(codon) when codon in ["UCU", "UCC", "UCA", "UCG"], do: "Serine"
  defp translate!(codon) when codon in ["UGG"], do: "Tryptophan"
  defp translate!(codon) when codon in ["UAU", "UAC"], do: "Tyrosine"
  defp translate!(codon) when codon in ["UAA", "UAG", "UGA"], do: "STOP"
  defp translate!(_), do: @invalid_rna

  @doc """
  Given an RNA string, return a list of proteins specified by codons, in order.
  """
  @spec of_rna(String.t()) :: {:ok, list(String.t())} | {:error, String.t()}
  def of_rna(rna) do
    proteins = rna
    |> String.split(~r/[[:upper:]]{3}/, include_captures: true, trim: true)
    |> Enum.map(&translate!/1)

    remaining_proteins = proteins
    |> Enum.find_index(&(&1 == "STOP"))
    |> remove_if_stop(proteins)

    remaining_proteins
    |> Enum.any?(&(&1 == @invalid_rna))
    |> check_for_errors(remaining_proteins)
  end

  defp check_for_errors(false, proteins), do: {:ok, proteins}
  defp check_for_errors(true, _), do: {:error, "invalid RNA"}

  defp remove_if_stop(nil, proteins), do: proteins
  defp remove_if_stop(stop_index, proteins), do: Enum.drop(proteins, stop_index - length(proteins))

  @doc """
  Given a codon, return the corresponding protein
  """
  @spec of_codon(String.t()) :: {:ok, String.t()} | {:error, String.t()}
  def of_codon(codon) do
    protein = translate!(codon)
    case protein do
      @invalid_rna -> {:error, "invalid codon"}
      _ -> {:ok, protein}
    end
  end
end
