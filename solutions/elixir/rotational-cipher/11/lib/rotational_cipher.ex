defmodule RotationalCipher do
  @doc """
  Given a plaintext and amount to shift by, return a rotated string.

  Example:
  iex> RotationalCipher.rotate("Attack at dawn", 13)
  "Nggnpx ng qnja"
  """

  @alphabet_lower Enum.to_list(?a..?z)
  @alphabet_upper Enum.to_list(?A..?Z)

  @spec rotate(text :: String.t(), shift :: integer) :: String.t()
  def rotate(text, shift) do

    String.graphemes(text)
    |> Enum.map(&rotate_char(&1, shift))
    |> Enum.join()
  end

  defp rotate_char(char, shift) do
    <<c>> = char
    cond do
      c in @alphabet_lower ->
        rotate_char(c, shift, @alphabet_lower)

      c in @alphabet_upper ->
        rotate_char(c, shift, @alphabet_upper)

      true ->
        char
    end
  end

  defp rotate_char(char, shift, alphabet) do
    index = Enum.find_index(alphabet, fn x -> x == char end)
    <<Enum.at(alphabet ++ alphabet, index + shift)>>
  end
end
