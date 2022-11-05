defmodule ArmstrongNumber do
  @moduledoc """
  Provides a way to validate whether or not a number is an Armstrong number
  """

  @spec valid?(integer) :: boolean
  def valid?(number) do
    digits = Integer.digits(number)

    sum_of_powers = digits 
    |> Enum.map(fn d -> :math.pow(d, length(digits)) end)
    |> Enum.sum()

    sum_of_powers == number

  end
end
