defmodule SimpleCipher do
  @doc """
  Given a `plaintext` and `key`, encode each character of the `plaintext` by
  shifting it by the corresponding letter in the alphabet shifted by the number
  of letters represented by the `key` character, repeating the `key` if it is
  shorter than the `plaintext`.

  For example, for the letter 'd', the alphabet is rotated to become:

  defghijklmnopqrstuvwxyzabc

  You would encode the `plaintext` by taking the current letter and mapping it
  to the letter in the same position in this rotated alphabet.

  abcdefghijklmnopqrstuvwxyz
  defghijklmnopqrstuvwxyzabc

  "a" becomes "d", "t" becomes "w", etc...

  Each letter in the `plaintext` will be encoded with the alphabet of the `key`
  character in the same position. If the `key` is shorter than the `plaintext`,
  repeat the `key`.

  Example:

  plaintext = "testing"
  key = "abc"

  The key should repeat to become the same length as the text, becoming
  "abcabca". If the key is longer than the text, only use as many letters of it
  as are necessary.
  """

  def encode(plaintext, key) do
    # IO.puts(plaintext)
    full_key = enumerate_key(key, String.length(plaintext))
    # IO.puts(full_key)
    pt_chars = String.to_charlist(plaintext)
    key_chars = String.to_charlist(full_key)

    IO.inspect(pt_chars)
    IO.inspect(key_chars)

    matched_char_pairs = List.zip([pt_chars, key_chars])
    char_pair_deltas = Enum.map(matched_char_pairs, fn {p1, p2} -> 97 + p1 - p2 end)
    IO.inspect(char_pair_deltas)

    List.to_string(char_pair_deltas)
  end

  @doc """
  Given a `ciphertext` and `key`, decode each character of the `ciphertext` by
  finding the corresponding letter in the alphabet shifted by the number of
  letters represented by the `key` character, repeating the `key` if it is
  shorter than the `ciphertext`.

  The same rules for key length and shifted alphabets apply as in `encode/2`,
  but you will go the opposite way, so "d" becomes "a", "w" becomes "t",
  etc..., depending on how much you shift the alphabet.
  """
  def decode(ciphertext, key) do
    ciphertext
  end

  defp enumerate_key(key, length) do
    if (String.length(key) > length) do
      String.slice(key, 0..length - 1)
    else
      String.slice(String.duplicate(key, div(length, String.length(key))), 0..length)
    end

  end
end
