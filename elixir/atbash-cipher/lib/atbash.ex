defmodule Atbash do
  @doc """
  Encode a given plaintext to the corresponding ciphertext

  ## Examples

  iex> Atbash.encode("completely insecure")
  "xlnko vgvob rmhvx fiv"
  """
  @spec encode(String.t()) :: String.t()
  def encode(plaintext) do
    plaintext
    |> String.downcase()
    |> String.to_charlist()
    |> Enum.map(&encode_char/1)
    |> List.to_string()
    |> String.codepoints()
    |> Enum.chunk_every(5)
    |> Enum.join(" ")
  end

  defp encode_char(char) when char >= ?a and char <= ?z, do: ?a + ?z - char
  defp encode_char(char) when char >= ?0 and char <= ?9, do: char
  defp encode_char(_), do: ''

  @spec decode(String.t()) :: String.t()
  def decode(cipher) do
    cipher
    |> String.replace(" ", "")
    |> String.to_charlist()
    |> Enum.map(&decode_char/1)
    |> List.to_string()
  end

  defp decode_char(char) when char >= ?a and char <= ?z, do: ?a + ?z - char
  defp decode_char(char) when char >= ?0 and char <= ?9, do: char
end
