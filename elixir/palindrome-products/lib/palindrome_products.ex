defmodule PalindromeProducts do
  @doc """
  Generates all palindrome products from an optionally given min factor (or 1) to a given max factor.
  """
  @spec generate(non_neg_integer, non_neg_integer) :: map
  def generate(max_factor, min_factor \\ 1)

  def generate(max_factor, min_factor) when max_factor < min_factor do
    raise ArgumentError
  end

  def generate(max_factor, min_factor) do
    generate_factors(min_factor..max_factor)
    |> List.flatten()
    |> Enum.reduce(Map.new(), fn map, result -> merge_factors(result, map) end)
    |> Map.filter(fn {product, _} -> palindrome?(product) end)
    |> normalise()
  end

  defp normalise(palindromes) do
    to_update =
      palindromes |> Map.filter(fn {_, factors} -> not is_list(hd(factors)) end) |> Map.keys()

    if length(to_update) >= 1 do
      Map.update!(palindromes, hd(to_update), fn factors -> [factors] end)
    else
      palindromes
    end
  end

  defp palindrome?(product) do
    product_string = Integer.to_string(product)
    product_string == String.reverse(product_string)
  end

  defp generate_factors(range) do
    Enum.map(range, fn i -> Enum.map(range, fn j -> product_with_factors(i, j) end) end)
  end

  defp product_with_factors(factor1, factor2) do
    %{(factor1 * factor2) => Enum.sort([factor1, factor2])}
  end

  defp merge_factors(result, map) when is_map(map) do
    Map.merge(result, map, fn _product, factors1, factors2 ->
      merge_factors(factors1, factors2)
    end)
  end

  defp merge_factors(factor, factor), do: [factor]

  defp merge_factors(factor1, factor2) do
    case factor2 in factor1 do
      true -> factor1
      false -> [factor1 | [factor2]]
    end
  end
end
