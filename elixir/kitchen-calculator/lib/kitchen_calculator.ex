defmodule KitchenCalculator do
  @milliliter_per_unit %{:cup => 240, :milliliter => 1, :fluid_ounce => 30, :teaspoon => 5, :tablespoon => 15}

  def get_volume({_, volume}) do
    volume
  end

  def to_milliliter({unit, volume}) do
    {:milliliter, @milliliter_per_unit[unit] * volume}
  end

  def from_milliliter({_, volume}, unit) do
    {unit, volume / @milliliter_per_unit[unit]}
  end

  def convert(volume_pair, unit) do
    volume_pair
    |> to_milliliter
    |> from_milliliter(unit)
  end
end
