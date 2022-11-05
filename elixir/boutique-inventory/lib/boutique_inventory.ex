defmodule BoutiqueInventory do
  def sort_by_price(inventory) do
    Enum.sort_by(inventory, &(&1.price))
  end

  def with_missing_price(inventory) do
    Enum.filter(inventory, &(is_nil(&1[:price])))
  end

  def increase_quantity(item, count) do
    updated_quantities = 
    Enum.map(item[:quantity_by_size], fn {k, v} -> {k, v + count} end)
    |> Map.new()

    Map.update!(item, :quantity_by_size, fn _ -> updated_quantities end)
  end

  def total_quantity(item) do
    item[:quantity_by_size]
    |> Map.values()
    |> Enum.reduce(0, &+/2)
  end
end
