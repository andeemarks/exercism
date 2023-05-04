defmodule CollatzConjecture do
  defguardp is_even(value) when rem(value, 2) == 0

  @doc """
  calc/1 takes an integer and returns the number of steps required to get the
  number to 1 when following the rules:
    - if number is odd, multiply with 3 and add 1
    - if number is even, divide by 2
  """
  @spec calc(input :: pos_integer()) :: non_neg_integer()
  def calc(input), do: calc(input, 0)

  defp calc(input, count) when input > 1 and is_even(input) do
    calc(trunc(input / 2), count + 1)
  end

  defp calc(input, count) when input > 1 and not is_even(input) do
    calc(input * 3 + 1, count + 1)
  end

  defp calc(1, count), do: count
end
