defmodule LibraryFees do
  def datetime_from_string(string) do
    elem(NaiveDateTime.from_iso8601(string), 1)
  end

  def before_noon?(datetime) do
    time = NaiveDateTime.to_time(datetime)
    noon = elem(Time.new(12, 0, 0, 0), 1)
    Time.compare(time, noon) == :lt
  end

  defp days_to_seconds(days), do: 60 * 60 * 24 * days

  def return_date(checkout_datetime) do
    if before_noon?(checkout_datetime) do
      checkout_datetime
      |> NaiveDateTime.add(days_to_seconds(28), :second)
      |> NaiveDateTime.to_date()
    else
      checkout_datetime
      |> NaiveDateTime.add(days_to_seconds(29), :second)
      |> NaiveDateTime.to_date()
    end
  end

  defp late_penalty_for(days) when days <= 0, do: 0
  defp late_penalty_for(days), do: days

  def days_late(planned_return_date, actual_return_datetime) do
    actual_return_date = NaiveDateTime.to_date(actual_return_datetime)
    days_difference = Date.diff(actual_return_date, planned_return_date)
    late_penalty_for(days_difference)
  end

  def monday?(datetime) do
    datetime
    |> NaiveDateTime.to_date
    |> Date.day_of_week() == 1
  end

  defp calculate_fee_discount(return) do
    if monday?(return) do
      0.50
    else
      1
    end
  end

  def calculate_late_fee(checkout, return, rate) do
    expected_return = checkout
    |> datetime_from_string()
    |> return_date()

    days = days_late(expected_return, datetime_from_string(return))

    return
    |> datetime_from_string()
    |> calculate_fee_discount()
    |> Kernel.*(rate)
    |> Kernel.*(days)
    |> Kernel.trunc()
  end
end
