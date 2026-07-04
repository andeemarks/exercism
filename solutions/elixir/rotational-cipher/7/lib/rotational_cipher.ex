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
          rotate_char(c, shift, alphabet_lower)

        c in alphabet_upper ->
          rotate_char(c, shift, alphabet_upper)

        true ->
          char
      end
    end)
    |> Enum.join()
  end

  defp rotate_char(char, shift, alphabet) do
    index = Enum.find_index(alphabet, fn x -> x == char end)
    <<Enum.at(alphabet ++ alphabet, index + shift)>>
  end
end
