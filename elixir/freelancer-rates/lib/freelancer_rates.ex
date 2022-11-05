defmodule FreelancerRates do
  def daily_rate(hourly_rate), do: hourly_rate * 8.0

  def apply_discount(before_discount, discount) when discount == 0, do: before_discount

  def apply_discount(before_discount, discount) when discount > 0 do
    before_discount - (before_discount * (discount / 100))
  end

  def monthly_rate(hourly_rate, discount) do
    round(Float.ceil(apply_discount(daily_rate(hourly_rate) * 22, discount)))
  end

  def days_in_budget(budget, hourly_rate, discount) do
    Float.floor(budget / apply_discount(daily_rate(hourly_rate), discount) * 10) / 10
  end
end
