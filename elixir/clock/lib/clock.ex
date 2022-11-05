defmodule Clock do
  defstruct hour: 0, minute: 0

  @doc """
  Returns a clock that can be represented as a string:

      iex> Clock.new(8, 9) |> to_string
      "08:09"
  """
  @spec new(integer, integer) :: Clock
  def new(hour, minute) do
    normalise(%Clock{hour: hour, minute: minute})
  end

  @doc """
  Adds two clock times:

      iex> Clock.new(10, 0) |> Clock.add(3) |> to_string
      "10:03"
  """
  @spec add(Clock, integer) :: Clock
  def add(%Clock{hour: hour, minute: minute}, add_minute) do
    %Clock{hour: hour, minute: minute + add_minute}
  end

  defp adjust_minute(minute) when minute < 0, do: rem(60 + rem(minute, 60), 60)
  defp adjust_minute(minute) when minute >= 60, do: rem(minute, 60)
  defp adjust_minute(minute), do: minute

  defp adjust_hour(hour, offset) when hour + offset < 0 , do: 24 + rem(hour + offset, 24)
  defp adjust_hour(hour, offset) when hour + offset < 24, do: hour + offset
  defp adjust_hour(hour, offset) when hour + offset >= 24, do: rem(hour + offset, 24)

  defp hour_offset(minute) when minute >= 60, do: div(minute, 60)
  defp hour_offset(minute) when minute < 0 and rem(minute, 60) == 0, do: rem(div(minute, 60), 24)
  defp hour_offset(minute) when minute < 0, do: rem(div(minute, 60) - 1, 24)
  defp hour_offset(_), do: 0

  def normalise(clock) do
    minute = adjust_minute(clock.minute)
    offset = hour_offset(clock.minute)
    hour = adjust_hour(clock.hour, offset)

    %Clock{hour: hour, minute: minute}
  end

  defimpl String.Chars, for: Clock do

    defp format_time_unit(unit) do
      unit
      |> Integer.to_string()
      |> String.pad_leading(2, "0")
    end

    defp format_hour(hour), do: format_time_unit(hour)
    defp format_minute(minute), do: format_time_unit(minute)

    def to_string(term) do
      clock = Clock.normalise(term)
      minute_str = format_minute(clock.minute)
      hour_str = format_hour(clock.hour)
      "#{hour_str}:#{minute_str}"
    end

  end

end
