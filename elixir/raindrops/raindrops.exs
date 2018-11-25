defmodule Raindrops do
  @doc """
  Returns a string based on raindrop factors.

  - If the number contains 3 as a prime factor, output 'Pling'.
  - If the number contains 5 as a prime factor, output 'Plang'.
  - If the number contains 7 as a prime factor, output 'Plong'.
  - If the number does not contain 3, 5, or 7 as a prime factor,
    just pass the number's digits straight through.
  """

  def factor(1), do: [1]

  def factor(n) do
    for(i <- 1..div(n, 2), rem(n, i) == 0, do: i) ++ [n]
  end

  @spec convert(pos_integer) :: String.t()
  def convert(number) do
    factors = factor(number)
    s = if Enum.member?(factors, 3), do: "Pling", else: ""
    s = if Enum.member?(factors, 5), do: s <> "Plang", else: s
    s = if Enum.member?(factors, 7), do: s <> "Plong", else: s
    s = if s == "", do: Integer.to_string(number), else: s
  end
end
