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

  @double_alphabet "abcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyz"

  def encode(plaintext, key) do
    code_common(plaintext, key, &encode_char/1)
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
    code_common(ciphertext, key, &decode_char/1)
  end

  defp code_common(text, key, helper) do
    key_chars = scale_key(key, String.length(text))
    text
    |> String.to_charlist
    |> Enum.zip(key_chars)
    |> Enum.map(helper)
    |> List.to_string
  end
    
  defp encode_char(cipher_key_tuple) do
    [cipher_char, key_char] = Tuple.to_list(cipher_key_tuple)
    char_pos_in_alphabet = cipher_char - ?a # first alpha
    key_pos_in_alphabet = key_char - ?a # diff from a

    String.at(@double_alphabet, char_pos_in_alphabet + key_pos_in_alphabet)
  end

  defp decode_char(cipher_key_tuple) do
    [cipher_char, key_char] = Tuple.to_list(cipher_key_tuple)
    char_pos_in_alphabet = cipher_char - ?a + (?z - ?a) + 1 # second alpha
    key_pos_in_alphabet = key_char - ?a # diff from a

    String.at(@double_alphabet, char_pos_in_alphabet - key_pos_in_alphabet)
  end

  defp scale_key(key, size) do
    key 
    |> String.duplicate(div(size, String.length(key)) + 1)
    |> String.slice(0, size)
    |> String.to_charlist
  end

  def generate_key(length) do
    lower_chars = Enum.to_list(?a..?z)
    lower_chars
    |> List.duplicate(div(length, length(lower_chars)) + 1)
    |> Enum.concat
    |> Enum.take_random(length)
    |> List.to_string
  end
end
