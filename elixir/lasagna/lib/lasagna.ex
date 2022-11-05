defmodule Lasagna do
  def expected_minutes_in_oven() do
    40
  end

  def remaining_minutes_in_oven(minutes) do
    expected_minutes_in_oven() - minutes
  end

  def preparation_time_in_minutes(layer_count) do
    2 * layer_count
  end

  def total_time_in_minutes(layer_count, elapsed_time) do
    preparation_time_in_minutes(layer_count) + elapsed_time
  end

  def alarm() do 
    "Ding!"
  end
end
