defmodule DNA do
  def encode_nucleotide(code_point) do
    case code_point do
      ?\s -> 0b0000
      ?A -> 0b0001
      ?C -> 0b0010
      ?G -> 0b0100
      ?T -> 0b1000
    end
  end

  def decode_nucleotide(<<encoded_code::4>>) do
    case encoded_code do
      0b0000 -> ' '
      0b0001 -> 'A'
      0b0010 -> 'C'
      0b0100 -> 'G'
      0b1000 -> 'T'
    end
  end

  def decode_nucleotide(encoded_code) do
    case encoded_code do
      0b0000 -> ?\s
      0b0001 -> ?A
      0b0010 -> ?C
      0b0100 -> ?G
      0b1000 -> ?T
    end
  end

  def encode(dna) when length(dna) == 1, do: <<encode_nucleotide(hd(dna))::4>>

  def encode(dna) do
    dna
    |> Enum.map(&<<encode_nucleotide(&1)::4>>)
    |> Enum.into(<<>>)
  end

  def decode(dna), do: decode(dna, '')
  defp decode(<<0::0>>, result), do: result

  defp decode(<<dna::4, rest::bitstring>>, result) do
    decode(rest, result ++ [decode_nucleotide(dna)])
  end
end
