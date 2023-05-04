defmodule Meetup do
  @moduledoc """
  Calculate meetup dates.
  """

  @type weekday ::
          :monday
          | :tuesday
          | :wednesday
          | :thursday
          | :friday
          | :saturday
          | :sunday

  @type schedule :: :first | :second | :third | :fourth | :last | :teenth

  @doc """
  Calculate a meetup date.

  The schedule is in which week (1..4, last or "teenth") the meetup date should
  fall.
  """
  @spec meetup(pos_integer, pos_integer, weekday, schedule) :: Date.t()
  def meetup(year, month, weekday, :teenth) do
    date_in_second_week = meetup(year, month, weekday, :second)

    if date_in_second_week.day >= 13 && date_in_second_week.day <= 19 do
      date_in_second_week
    else
      meetup(year, month, weekday, :third)
    end
  end

  def meetup(year, month, weekday, :last) do
    date_in_fourth_week = meetup(year, month, weekday, :fourth)

    if date_in_fourth_week.day + 7 > Date.days_in_month(date_in_fourth_week) do
      date_in_fourth_week
    else
      Date.add(date_in_fourth_week, 7)
    end
  end

  def meetup(year, month, weekday, schedule) do
    {_, first_of_month} = Date.new(year, month, 1)
    day_of_first_of_month = Date.day_of_week(first_of_month)

    index_of_weekday = weekday_index(weekday)
    day_offset = day_offset(day_of_first_of_month, index_of_weekday)

    case schedule do
      :first ->
        Date.add(first_of_month, day_offset)

      :second ->
        Date.add(first_of_month, 7 + day_offset)

      :third ->
        Date.add(first_of_month, 14 + day_offset)

      :fourth ->
        Date.add(first_of_month, 21 + day_offset)
    end
  end

  defp weekday_index(weekday) do
    case weekday do
      :monday -> 1
      :tuesday -> 2
      :wednesday -> 3
      :thursday -> 4
      :friday -> 5
      :saturday -> 6
      :sunday -> 7
    end
  end

  defp day_offset(first_day, target_day) when first_day <= target_day, do: target_day - first_day

  defp day_offset(first_day, target_day) when first_day > target_day,
    do: 7 - (first_day - target_day)
end
