defmodule Prime do
  @doc """
  Generates the nth prime.
  """
  @spec nth(non_neg_integer) :: non_neg_integer
  def nth(count) do
       Stream.iterate({2, true}, fn {a, _} -> {a + 1, prime?(a + 1)} end)
       |> Stream.filter(fn {_, prime_status} -> prime_status == true end)
       |> Enum.take(count)
       |> Enum.at(count - 1)
       |> elem(0)
  end

  defp prime?(number) do
    div = max(2, Integer.floor_div(number, 2))
    divisors = for n <- div..2, rem(number, n) == 0, do: n

    divisors == []
  end
end
