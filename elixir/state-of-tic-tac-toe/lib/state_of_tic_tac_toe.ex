defmodule StateOfTicTacToe do
  defmodule Board do

    def rows(board) do
      Enum.map(String.split(board, "\n"), &String.codepoints/1)
    end

    def cols(board) do
      [row_1, row_2, row_3, _] = rows(board) 
      col_1 = [Enum.at(row_1, 0), Enum.at(row_2, 0), Enum.at(row_3, 0)]
      col_2 = [Enum.at(row_1, 1), Enum.at(row_2, 1), Enum.at(row_3, 1)]
      col_3 = [Enum.at(row_1, 2), Enum.at(row_2, 2), Enum.at(row_3, 2)]

      [col_1, col_2, col_3]
    end

    def diags(board) do
      [row_1, row_2, row_3, _] = rows(board)
      diag_1 = [Enum.at(row_1, 0), Enum.at(row_2, 1), Enum.at(row_3, 2)]
      diag_2 = [Enum.at(row_1, 2), Enum.at(row_2, 1), Enum.at(row_3, 0)]

      [diag_1, diag_2]
    end

    def complete?(board) do
      board 
      |> String.codepoints() 
      |> Enum.count(&(&1 == "."))
      == 0
    end

    def turn_counts(board) do
      board
      |> String.replace("\n", "")
      |> String.codepoints()
      |> Enum.frequencies()
    end
  end

  @doc """
  Determine the state a game of tic-tac-toe where X starts.
  """
  @spec game_state(board :: String.t()) :: {:ok, :win | :ongoing | :draw} | {:error, String.t()}
  def game_state(board) do
    {board_error_result, board_error_message} = check_board_error(board)
    {invalid_win_combo_result, invalid_win_error_message} = check_invalid_win_combos(board)
    cond do
      board_error_result == :error -> {:error, board_error_message}
      invalid_win_combo_result == :error -> {:error, invalid_win_error_message}
      count_valid_wins(board) >= 1 -> {:ok, :win}
      Board.complete?(board) -> {:ok, :draw}
      true -> {:ok, :ongoing}
    end
    
  end

  defp check_invalid_win_combos(board) do
    row_win_count = board |> Board.rows() |> Enum.count(&win?/1)
    column_win_count = board |> Board.cols() |> Enum.count(&win?/1)

    cond do
      row_win_count > 1 -> {:error, "Impossible board: game should have ended after the game was won"}
      column_win_count > 1 -> {:error, "Impossible board: game should have ended after the game was won"}
      true -> {:ok, ""}
    end
  end

  defp count_valid_wins(board) do
    Enum.count(Board.rows(board) ++ Board.cols(board) ++ Board.diags(board), &win?/1)
  end
  
  defp check_board_error(board) do
    turn_counts = Board.turn_counts(board)

    check_turn_counts(turn_counts["X"], turn_counts["O"])
  end

  defp check_turn_counts(x_turn_count, nil), do: check_turn_counts(x_turn_count, 0)
  defp check_turn_counts(nil, o_turn_count), do: check_turn_counts(0, o_turn_count)
  defp check_turn_counts(x_turn_count, o_turn_count) do
    cond do
      x_turn_count - o_turn_count >= 2 -> {:error, "Wrong turn order: X went twice"}
      o_turn_count - x_turn_count >= 1 -> {:error, "Wrong turn order: O started"}
      true -> {:ok, ""}
    end
  end

  defp win?(["X", "X", "X"]), do: true
  defp win?(["O", "O", "O"]), do: true
  defp win?(_), do: false
end
