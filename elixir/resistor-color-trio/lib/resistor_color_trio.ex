defmodule ResistorColorTrio do
  @colours [:black, :brown, :red, :orange, :yellow, :green, :blue, :violet, :grey, :white]

  @doc """
  Calculate the resistance value in ohms from resistor colors
  """
  @spec label(colors :: [atom]) :: {number, :ohms | :kiloohms | :megaohms | :gigaohms}
  def label(colors) do
    tens = Enum.find_index(@colours, fn colour -> colour == Enum.at(colors, 0) end)
    digits = Enum.find_index(@colours, fn colour -> colour == Enum.at(colors, 1) end)
    magnitude = Enum.find_index(@colours, fn colour -> colour == Enum.at(colors, 2) end)

    resistance = (tens * 10 + digits) * Integer.pow(10, magnitude)
    adjust_for_magnitude(resistance)
  end

  defp adjust_for_magnitude(resistance) when resistance > 1_000_000_000,
    do: {resistance / 1_000_000_000, :gigaohms}

  defp adjust_for_magnitude(resistance) when resistance > 1_000_000,
    do: {resistance / 1_000_000, :megaohms}

  defp adjust_for_magnitude(resistance) when resistance > 1000, do: {resistance / 1000, :kiloohms}
  defp adjust_for_magnitude(resistance), do: {resistance, :ohms}
end
