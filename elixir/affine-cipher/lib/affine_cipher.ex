import Integer, only: [mod: 2]
defmodule AffineCipher do
  @typedoc """
  A type for the encryption key
  """
  @type key() :: %{a: integer, b: integer}
  @alphabet String.codepoints("abcdefghijklmnopqrstuvwxyz")
  @m length(@alphabet)
  @digits String.codepoints("0123456789")

  @doc """
  Encode an encrypted message using a key
  """
  @spec encode(key :: key(), message :: String.t()) :: {:ok, String.t()} | {:error, String.t()}
  def encode(%{a: a, b: b}, message) do
    if Integer.gcd(a, @m) != 1 do
      {:error, "a and m must be coprime."}
    else
      encoded_message = 
      message
      |> to_chars()
      |> encode_chars(a, b)
      |> to_words()
      {:ok, encoded_message}
    end
  end

  defp to_chars(message) do
    message
    |> String.downcase()
    |> String.codepoints()
  end

  defp encode_chars(chars, a, b) do
    chars
    |> Enum.filter(&(&1 in @alphabet or &1 in @digits))
    |> Enum.map(&(encode_char(&1, a, b)))
  end

  defp encode_char(char, _a, _b) when char in @digits, do: char
  defp encode_char(char, a, b) when char in @alphabet do
    index = find_alpha_index(char)
    Enum.at(@alphabet, mod_m(index * a + b))
  end

  defp to_words(chars) do
    chars
    |> Enum.chunk_every(5)
    |> Enum.intersperse(" ")
    |> Enum.join()
  end

  defp find_alpha_index(char), do: Enum.find_index(@alphabet, &(&1 == char))

  @doc """
  Decode an encrypted message using a key
  """
  @spec decode(key :: key(), message :: String.t()) :: {:ok, String.t()} | {:error, String.t()}
  def decode(%{a: a, b: b}, message) do
    if Integer.gcd(a, @m) != 1 do
      {:error, "a and m must be coprime."}
    else
      decoded_message = 
      message
      |> from_words()
      |> decode_chars(a, b)
      |> to_message()

      {:ok, decoded_message}
    end
  end

  defp from_words(message) do
    message
    |> String.replace(" ", "")
    |> String.codepoints()
  end

  defp decode_chars(chars, a, b) do
    chars 
    |> Enum.map(&(decode_char(&1, a, b)))
  end

  defp to_message(chars), do: Enum.join(chars)

  defp decode_char(char, _a, _b) when char in @digits, do: char
  defp decode_char(char, a, b) do
    index = find_alpha_index(char)
    Enum.at(@alphabet, mod_m(mmi(a) * (index - b)))
  end

  # Stolen from https://www.geeksforgeeks.org/multiplicative-inverse-under-modulo-m/
  defp mmi(a) do
    List.first(Enum.filter(1..@m, &(mmi?(a, &1))))
  end

  defp mmi?(a, x), do: mod_m(mod_m(a) * mod_m(x)) == 1

  defp mod_m(n), do: mod(n, @m)
end
