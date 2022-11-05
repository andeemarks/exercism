defmodule BeerSong do

  defp format_bottles(1), do: "bottle"
  defp format_bottles(_), do: "bottles"

  defp format_bottle_subject(1), do: "it"
  defp format_bottle_subject(_), do: "one"

  defp format_remaining_bottles(1), do: "no more"
  defp format_remaining_bottles(number), do: number - 1

  defp format_current_bottles(number, _)
  defp format_current_bottles(0, true), do: "No more"
  defp format_current_bottles(0, false), do: "no more"
  defp format_current_bottles(number, _), do: number

  defp format_final_phrase(0) do
    "Go to the store and buy some more, 99 #{format_bottles(99)} of beer on the wall."
  end

  defp format_final_phrase(number) do
    "Take #{format_bottle_subject(number)} down and pass it around, #{format_remaining_bottles(number)} #{format_bottles(number - 1)} of beer on the wall."
  end

  @doc """
  Get a single verse of the beer song
  """
  @spec verse(integer) :: String.t()
  def verse(number) do
    """
    #{format_current_bottles(number, true)} #{format_bottles(number)} of beer on the wall, #{format_current_bottles(number, false)} #{format_bottles(number)} of beer.
    #{format_final_phrase(number)}
    """
  end

  @doc """
  Get the entire beer song for a given range of numbers of bottles.
  """
  @spec lyrics(Range.t()) :: String.t()
  def lyrics(range \\ 99..0) do
    range 
    |> Enum.map(&verse/1)
    |> Enum.join("\n")
  end
end
