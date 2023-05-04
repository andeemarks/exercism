defmodule PerfectNumbers do
  @doc """
  Determine the aliquot sum of the given `number`, by summing all the factors
  of `number`, aside from `number` itself.

  Based on this sum, classify the number as:

  :perfect if the aliquot sum is equal to `number`
  :abundant if the aliquot sum is greater than `number`
  :deficient if the aliquot sum is less than `number`
  """
  @spec classify(number :: integer) :: {:ok, atom} | {:error, String.t()}
  def classify(number) when number < 1,
    do: {:error, "Classification is only possible for natural numbers."}

  def classify(number) when number == 1, do: {:ok, :deficient}

  def classify(number) do
    factors = Enum.filter(Enum.to_list(1..trunc(number / 2)), fn x -> rem(number, x) == 0 end)
    aliquot_sum = Enum.sum(factors)

    case number do
      number when number == aliquot_sum -> {:ok, :perfect}
      number when number < aliquot_sum -> {:ok, :abundant}
      number when number > aliquot_sum -> {:ok, :deficient}
    end
  end
end
