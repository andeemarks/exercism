defmodule Username do
  def sanitize([]), do: []
  def sanitize(username) do
    username
    |> Enum.map(&sanitize_char/1)
    |> Enum.filter(&(not is_nil(&1)))
    |> List.flatten()
  end

  defp sanitize_char(char) when char >= ?a and char <= ?z, do: char 
  defp sanitize_char(char) do
    case char do
      ?ä -> 'ae'
      ?ß -> 'ss'
      ?ö -> 'oe'
      ?ü -> 'ue'
      ?_ -> ?_
      _ -> nil
    end

  end
end
