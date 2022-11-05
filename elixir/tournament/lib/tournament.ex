defmodule Tournament do
  @header "Team                           | MP |  W |  D |  L |  P"

  defmodule Result do
    defstruct [team: "", matches_played: 0, wins: 0, draws: 0, losses: 0, points: 0]

    def empty, do: %Result{}
    def win, do: %Result{matches_played: 1, wins: 1, draws: 0, losses: 0, points: 3}
    def loss, do: %Result{matches_played: 1, wins: 0, draws: 0, losses: 1, points: 0}
    def draw, do: %Result{matches_played: 1, wins: 0, draws: 1, losses: 0, points: 1}
  end

  @doc """
  Given `input` lines representing two teams and whether the first of them won,
  lost, or reached a draw, separated by semicolons, calculate the statistics
  for each team's number of games played, won, drawn, lost, and total points
  for the season, and return a nicely-formatted string table.

  A win earns a team 3 points, a draw earns 1 point, and a loss earns nothing.

  Order the outcome by most total points for the season, and settle ties by
  listing the teams in alphabetical order.
  """
  @spec tally(input :: list(String.t())) :: String.t()
  def tally([]), do: @header
  def tally(input) when is_binary(input) do
    try do
      [t1, t2, result] = String.split(input, ";", trim: true)
      format_result_lines(t1, t2, result)
    rescue 
      MatchError -> []
    end
  end

  def tally(input) do
    lines = input
    |> Enum.map(&tally/1)
    |> List.flatten()
    |> Enum.group_by(&(&1.team))
    |> Map.values()
    |> Enum.map(&merge_results/1)
    |> Enum.sort(&(&1.points >= &2.points))
    |> Enum.map(&format_line/1)
    |> Enum.join("\n")

    "#{@header}\n#{lines}"
  end

  defp merge_result_fields(:__struct__, _, _), do: nil
  defp merge_result_fields(:team, _, value), do: value
  defp merge_result_fields(_, value1, value2), do: value1 + value2

  defp merge_result_records(result1, result2) do
    Map.merge(result1, result2, &merge_result_fields/3)
  end

  defp merge_results(results) do
    Enum.reduce(results, Result.empty, fn result, consolidation -> merge_result_records(consolidation, result) end)
  end

  defp format_result_lines(t1, t2, "win") do
    [%Result{Result.win() | team: t1}, %Result{Result.loss() | team: t2}]
  end

  defp format_result_lines(t1, t2, "loss") do
    [%Result{Result.win() | team: t2}, %Result{Result.loss() | team: t1}]
  end

  defp format_result_lines(t1, t2, "draw") do
    [%Result{Result.draw() | team: t2}, %Result{Result.draw() | team: t1}]
  end

  defp format_result_lines(_, _, _), do: []

  defp format_line(results) do
    "#{String.pad_trailing(results.team, 31)}|  #{results.matches_played} |  #{results.wins} |  #{results.draws} |  #{results.losses} |#{String.pad_leading(to_string(results.points), 3)}"
  end
end
