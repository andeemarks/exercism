defmodule GottaSnatchEmAll do
  @type card :: String.t()
  @type collection :: MapSet.t(card())

  @spec new_collection(card()) :: collection()
  def new_collection(card) do
    MapSet.new([card])
  end

  @spec add_card(card(), collection()) :: {boolean(), collection()}
  def add_card(card, collection) do
    {MapSet.member?(collection, card), MapSet.put(collection, card)}
  end

  @spec trade_card(card(), card(), collection()) :: {boolean(), collection()}
  def trade_card(your_card, their_card, your_collection) do
    if (MapSet.member?(your_collection, your_card)) do
      if (MapSet.member?(your_collection, their_card)) do
        {false, MapSet.delete(your_collection, your_card)}
      else
        {true, MapSet.delete(your_collection, your_card) |> MapSet.put(their_card)}
      end
    else
      {false, MapSet.put(your_collection, their_card)}
    end
  end

  @spec remove_duplicates([card()]) :: [card()]
  def remove_duplicates(cards) do
    MapSet.new(cards) |> MapSet.to_list() |> Enum.sort()
  end

  @spec extra_cards(collection(), collection()) :: non_neg_integer()
  def extra_cards(your_collection, their_collection) do
    MapSet.difference(your_collection, their_collection) |> MapSet.size()
  end

  defp boring_cards(collection1, collection2), do: MapSet.intersection(collection1, collection2)

  @spec boring_cards([collection()]) :: [card()]
  def boring_cards(collections) when collections == [], do: []
  def boring_cards(collections) do
    Enum.reduce(collections, List.first(collections), &boring_cards/2) |> MapSet.to_list() |> Enum.sort()
  end

  @spec total_cards([collection()]) :: non_neg_integer()
  def total_cards(collections) when collections == [], do: 0
  def total_cards(collections) do
    Enum.reduce(collections, List.first(collections), fn collection, cards -> MapSet.union(cards, collection) end) |>
    MapSet.size()
  end

  defp shiny?(card), do: String.starts_with?(card, "Shiny")

  @spec split_shiny_cards(collection()) :: {[card()], [card()]}
  def split_shiny_cards(collection) do
    {shiny_cards, non_shiny_cards} = MapSet.split_with(collection, &shiny?/1)

    {MapSet.to_list(shiny_cards) |> Enum.sort(), MapSet.to_list(non_shiny_cards) |> Enum.sort()}
  end

end
