defmodule LucasNumbers do
  @moduledoc """
  Lucas numbers are an infinite sequence of numbers which build progressively
  which hold a strong correlation to the golden ratio (φ or ϕ)

  E.g.: 2, 1, 3, 4, 7, 11, 18, 29, ...
  """
  def generate(number) when number < 0, do: raise ArgumentError, "count must be specified as an integer >= 1"
  def generate(number) when not is_number(number), do: raise ArgumentError, "count must be specified as an integer >= 1"
  def generate(1), do: [2]
  def generate(2), do: [2, 1]
  def generate(0), do: []
  def generate(count) do
    Stream.iterate({-1, 2}, fn {a, b} -> {b, a + b} end) 
    |> Enum.take(count) 
    |> Enum.map(&(Kernel.elem(&1, 1)))
  end
end
