defmodule HighScore do
  @initial_score 0

  def new() do
    %{}
  end

  def add_player(scores, name, score \\ @initial_score) do
    Map.put(scores, name, score)
  end

  def remove_player(scores, name) do
    elem(Map.pop(scores, name), 1)
  end

  def reset_score(scores, name) do
    Map.update(scores, name, @initial_score, &(&1 = @initial_score))
  end

  def update_score(scores, name, score) do
    Map.update(scores, name, score, &(&1 = &1 + score))
  end

  def get_players(scores) do
    Map.keys(scores)
  end
end
