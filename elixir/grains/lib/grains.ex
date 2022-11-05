defmodule Grains do
  @doc """
  Calculate two to the power of the input minus one.
  """
  @spec square(pos_integer()) :: {:ok, pos_integer()} | {:error, String.t()}
  def square(square) when square > 64 or square < 1, do: {:error, "The requested square must be between 1 and 64 (inclusive)"}
  def square(number), do: {:ok, grains_for(number)}

  defp grains_for(square) when square in [1, 2], do: square
  defp grains_for(square), do: power_of(2, square - 1)

  defp power_of(number, 1), do: number
  defp power_of(number, exp), do: number * power_of(number, exp - 1)

  @doc """
  Adds square of each number from 1 to 64.
  """
  @spec total :: {:ok, pos_integer()}
  def total do
    {:ok, Enum.reduce(1..64, fn square, total -> total + grains_for(square) end)}
  end
end
