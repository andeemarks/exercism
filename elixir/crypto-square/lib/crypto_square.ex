defmodule CryptoSquare do
  @doc """
  Encode string square methods
  ## Examples

    iex> CryptoSquare.encode("abcd")
    "ac bd"
  """
  @spec encode(String.t()) :: String.t()
  def encode(plaintext) do
    normal_plaintext = normalise(plaintext)
    row_length = row_length(normal_plaintext)

    encrypt(normal_plaintext, row_length)
  end

  defp encrypt(_, 0), do: ""

  defp encrypt(text, row_length) do
    text
    |> size_to_rectangle(row_length)
    |> break_into_rows(row_length)
    |> rows_to_rectangle
  end

  @spec size_to_rectangle(String.t(), integer) :: String.t()
  defp size_to_rectangle(text, row_length) do
    rectangle_size = round_up(String.length(text) / row_length) * row_length

    String.pad_trailing(text, rectangle_size)
  end

  defp break_into_rows(text, row_length) do
    text
    |> String.codepoints()
    |> Enum.chunk_every(row_length)
  end

  defp rows_to_rectangle(text) do
    text
    |> List.zip()
    |> Enum.map(&Tuple.to_list/1)
    |> Enum.map(&Enum.join/1)
    |> Enum.join(" ")
  end

  @spec normalise(String.t()) :: String.t()
  defp normalise(text) do
    text
    |> String.downcase()
    |> String.replace(~r/[^a-z1-9]/, "")
  end

  @spec row_length(String.t()) :: integer
  defp row_length(text) do
    text
    |> String.length()
    |> :math.sqrt()
    |> round_up
  end

  defp round_up(n), do: trunc(Float.ceil(n))
end
