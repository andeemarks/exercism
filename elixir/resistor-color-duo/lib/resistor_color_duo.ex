defmodule ResistorColorDuo do
  defp value_for_color(color) do
    %{ :black => 0, :brown => 1, :red => 2, :orange => 3, :yellow => 4, :green => 5, :blue => 6, :violet => 7, :grey => 8, :white => 9 }
    |> Map.fetch(color)
    |> elem(1)
  end

  @doc """
  Calculate a resistance value from two colors
  """
  @spec value(colors :: [atom]) :: integer
  def value(colors) do
    colors
    |> Enum.slice(0..1)
    |> Enum.map(&value_for_color/1)
    |> Enum.join("")
    |> String.to_integer
  end
end
