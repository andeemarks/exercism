defmodule Gigasecond do
  @doc """
  Calculate a date one billion seconds after an input date.
  """
  @spec from({{pos_integer, pos_integer, pos_integer}, {pos_integer, pos_integer, pos_integer}}) ::
          {{pos_integer, pos_integer, pos_integer}, {pos_integer, pos_integer, pos_integer}}
  def from({{year, month, day}, {hours, minutes, seconds}}) do
    adjusted_date = NaiveDateTime.new(year, month, day, hours, minutes, seconds)
    |> elem(1)
    |> NaiveDateTime.add(1_000_000_000)

    {{adjusted_date.year, adjusted_date.month, adjusted_date.day}, {adjusted_date.hour, adjusted_date.minute, adjusted_date.second}}
  end
end
