defmodule StringSeries do
  @doc """
  Given a string `s` and a positive integer `size`, return all substrings
  of that size. If `size` is greater than the length of `s`, or less than 1,
  return an empty list.
  """
  @spec slices(s :: String.t(), size :: integer) :: list(String.t())
  def slices(_s, size) when size <= 0, do: []
  def slices(s, size), do: slices(s, size, String.length(s))
  
  defp slices(_s, size, s_length) when size > s_length, do: []
  defp slices(s, size, s_length), do: Enum.map(0..s_length - size, fn i -> String.slice(s, i, size) end)

end
