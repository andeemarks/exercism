defmodule BoutiqueSuggestions do
  def get_combinations(tops, bottoms, options \\ [])
  def get_combinations([], [], _), do: []

  def get_combinations(tops, bottoms, options) do
    budget = Keyword.get(options, :maximum_price, 100.00)

    for t <- tops,
        b <- bottoms,
        non_clashing_colour?(t, b),
        within_budget?(t, b, budget),
        do: {t, b}
  end

  defp non_clashing_colour?(top, bottom), do: top.base_color != bottom.base_color
  defp within_budget?(top, bottom, max_price), do: top.price + bottom.price < max_price
end
