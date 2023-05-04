defmodule Bowling do
  @doc """
    Creates a new game of bowling that can be used to store the results of
    the game
  """

  @spec start() :: any
  def start do
    %{:frames => [], :bonuses => []}
  end

  defp is_frame_spare(frames) do
    Enum.sum(Enum.take(frames, 2)) == 10
  end

  defp is_last_frame(frames) do
    length(frames) == 20
  end

  defp is_strike_on_last_roll(frames) do
    List.last(frames) == 10
  end

  @doc """
    Records the number of pins knocked down on a single roll. Returns `any`
    unless there is something wrong with the given number of pins, in which
    case it returns a helpful error tuple.
  """

  @spec roll(any, integer) :: {:ok, any} | {:error, String.t()}
  def roll(game, roll) do
    cond do
      is_strike_on_last_roll(game.frames) ->
        {:ok, %{:frames => [roll | game.frames], :bonuses => [roll | game.bonuses]}}

      is_last_frame(game.frames) and is_frame_spare(game.frames) ->
        {:ok, %{:frames => [roll | game.frames], :bonuses => game.bonuses}}

      is_frame_spare(game.frames) ->
        {:ok, %{:frames => [roll | game.frames], :bonuses => [roll | game.bonuses]}}

      true ->
        {:ok, %{:frames => [roll | game.frames], :bonuses => game.bonuses}}
    end
  end

  @doc """
    Returns the score of a given game of bowling if the game is complete.
    If the game isn't complete, it returns a helpful error tuple.
  """

  @spec score(any) :: {:ok, integer} | {:error, String.t()}
  def score(game) do
    {:ok, Enum.sum(game.frames) + Enum.sum(game.bonuses)}
  end
end
