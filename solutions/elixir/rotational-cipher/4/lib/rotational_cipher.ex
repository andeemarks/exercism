defmodule RotationalCipher do
  @doc """
  Given a plaintext and amount to shift by, return a rotated string.

  Example:
  iex> RotationalCipher.rotate("Attack at dawn", 13)
  "Nggnpx ng qnja"
  """
  @spec rotate(text :: String.t(), shift :: integer) :: String.t()
  def rotate(text, shift) do
    alphabet_lower = ?a..?z |> Enum.to_list()
    alphabet_upper = ?A..?Z |> Enum.to_list()

    Enum.map(String.graphemes(text), fn char ->
      <<c>> = char
      cond do
        c in alphabet_lower ->
          index = Enum.find_index(alphabet_lower, fn x -> x == c end)
          <<Enum.at(alphabet_lower ++ alphabet_lower, index + shift)>>
          # <<new_char>>

        c in alphabet_upper ->
          index = Enum.find_index(alphabet_upper, fn x -> x == c end)
          new_char = Enum.at(alphabet_upper ++ alphabet_upper, index + shift)
          <<new_char>>

        true ->
          char
      end
    end)
    |> Enum.join()
  end
end
