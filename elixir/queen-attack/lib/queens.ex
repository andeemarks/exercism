defmodule Queens do
  @type t :: %Queens{black: {integer, integer}, white: {integer, integer}}
  defstruct [:white, :black]

  @doc """
  Creates a new set of Queens
  """
  @spec new(Keyword.t()) :: Queens.t()
  def new(opts \\ []) do
    build(Keyword.get(opts, :white), Keyword.get(opts, :black))
  end

  defp validate_pos({column, row}) when column in 0..7 and row in 0..7, do: :ok
  defp validate_pos({_, _}), do: raise(ArgumentError)

  defp build(white_pos, black_pos) when black_pos == white_pos do
    raise ArgumentError
  end

  defp build(white_pos, black_pos) when is_nil(black_pos) do
    validate_pos(white_pos)
    %Queens{white: white_pos}
  end

  defp build(white_pos, black_pos) when is_nil(white_pos) do
    validate_pos(black_pos)
    %Queens{black: black_pos}
  end

  defp build(white_pos, black_pos) do
    validate_pos(white_pos)
    validate_pos(black_pos)
    %Queens{black: black_pos, white: white_pos}
  end

  @doc """
  Gives a string representation of the board with
  white and black queen locations shown
  """
  @spec to_string(Queens.t()) :: String.t()
  def to_string(queens) do
    "_"
    |> String.duplicate(64)
    |> String.codepoints()
    |> show_queens(queens)
    |> Enum.intersperse(" ")
    |> Enum.chunk_every(16)
    |> Enum.map(&Enum.join/1)
    |> Enum.map(&String.trim/1)
    |> Enum.join("\n")
  end

  defp board_index_for({column, row}), do: column * 8 + row

  defp show_queens(board, %Queens{black: black_pos, white: nil}) do
    board
    |> List.replace_at(board_index_for(black_pos), "B")
  end

  defp show_queens(board, %Queens{black: nil, white: white_pos}) do
    board
    |> List.replace_at(board_index_for(white_pos), "W")
  end

  defp show_queens(board, %Queens{black: black_pos, white: white_pos}) do
    board
    |> List.replace_at(board_index_for(black_pos), "B")
    |> List.replace_at(board_index_for(white_pos), "W")
  end

  @doc """
  Checks if the queens can attack each other
  """
  @spec can_attack?(Queens.t()) :: boolean
  def can_attack?(%Queens{black: {column, _}, white: {column, _}}), do: true
  def can_attack?(%Queens{black: {_, row}, white: {_, row}}), do: true

  def can_attack?(%Queens{black: {black_column, black_row}, white: {white_column, white_row}}) do
    abs(white_column - black_column) == abs(white_row - black_row)
  end

  def can_attack?(_), do: false
end
