defmodule JigsawPuzzle do
  @doc """
  Fill in missing jigsaw puzzle details from partial data
  """

@type format() :: :landscape | :portrait | :square
@type t() :: %__MODULE__{
  pieces: pos_integer() | nil,
  rows: pos_integer() | nil,
  columns: pos_integer() | nil,
  format: format() | nil,
  aspect_ratio: float() | nil,
  border: pos_integer() | nil,
  inside: pos_integer() | nil
}

  defstruct [:pieces, :rows, :columns, :format, :aspect_ratio, :border, :inside]

  @spec data(jigsaw_puzzle :: JigsawPuzzle.t()) ::
  {:ok, JigsawPuzzle.t()} | {:error, String.t()}
  def data(spec) when spec.format == :square and not is_nil(spec.columns) and spec.columns != spec.rows, do: { :error, "Contradictory data" }
  def data(spec) when not is_nil(spec.pieces) and not is_nil(spec.aspect_ratio) do
    {rows, columns}  = matching_aspect_ratio_constraint(find_by_target(factors_of(spec.pieces), spec.pieces), spec.aspect_ratio)
    border_pieces = border_pieces(rows, columns)
    { :ok,
      %JigsawPuzzle{
        pieces: spec.pieces,
        rows: rows,
        columns: columns,
        format: format(spec.aspect_ratio),
        aspect_ratio: spec.aspect_ratio,
        border: border_pieces,
        inside: inside_pieces(spec.pieces, border_pieces)}
    }
  end
  def data(spec) when not is_nil(spec.rows) and spec.format == :square do
    rows = columns = spec.rows
    pieces = rows * columns
    border_pieces = border_pieces(rows, columns)
    { :ok,
      %JigsawPuzzle{
        pieces: pieces,
        rows: rows,
        columns: columns,
        format: spec.format,
        aspect_ratio: 1.0,
        border: border_pieces,
        inside: inside_pieces(pieces, border_pieces)}
    }
  end
  def data(spec) when spec.aspect_ratio == 1.0 and not is_nil(spec.inside) do
    inside_side = :math.sqrt(spec.inside)
    rows = columns = inside_side + 2
    pieces = rows * columns
    border_pieces = border_pieces(rows, columns)
    { :ok,
      %JigsawPuzzle{
        pieces: pieces,
        rows: rows,
        columns: columns,
        format: :square,
        aspect_ratio: spec.aspect_ratio,
        border: border_pieces,
        inside: spec.inside}
    }
  end
  def data(spec) when not is_nil(spec.aspect_ratio) and not is_nil(spec.rows) do
    rows = spec.rows
    columns = rows * spec.aspect_ratio
    border_pieces = border_pieces(rows, columns)
    { :ok,
      %JigsawPuzzle{
        pieces: rows * columns,
        rows: rows,
        columns: columns,
        format: format(spec.aspect_ratio),
        aspect_ratio: spec.aspect_ratio,
        border: border_pieces,
        inside: inside_pieces(rows * columns, border_pieces)}
    }
  end
  def data(spec) when not is_nil(spec.border) and spec.format == :portrait and not is_nil(spec.pieces) do
    {side1, side2}  = matching_border_constraint(find_by_target(factors_of(spec.pieces), spec.pieces), spec.border)

    rows = max(side1, side2)
    columns = min(side1, side2)
    { :ok,
      %JigsawPuzzle{
        pieces: spec.pieces,
        rows: rows,
        columns: columns,
        format: spec.format,
        aspect_ratio: columns / rows,
        border: spec.border,
        inside: inside_pieces(spec.pieces, spec.border)
      }
    }
  end
  def data(spec) when not is_nil(spec.border) and spec.format == :landscape and not is_nil(spec.pieces) do
    {side1, side2}  = matching_border_constraint(find_by_target(factors_of(spec.pieces), spec.pieces), spec.border)
    rows = min(side1, side2)
    columns = max(side1, side2)

    { :ok,
      %JigsawPuzzle{
        pieces: spec.pieces,
        rows: rows,
        columns: columns,
        format: spec.format,
        aspect_ratio: rows / columns,
        border: spec.border,
        inside: inside_pieces(spec.pieces, spec.border)
      }
    }
  end
  def data(_), do: { :error, "Insufficient data" }

  @spec factors_of(target :: pos_integer()) :: [pos_integer()]
  defp factors_of(target) do
    Enum.filter(1..target, fn i -> rem(target, i) == 0 end)
  end

  # @spec matching_border_constraint(list: [pos_integer()], border: pos_integer()) :: {pos_integer(), pos_integer()}
  defp matching_border_constraint(list, border) do
    list
    |> Enum.filter(fn {rows, columns} -> rows * 2 + ((columns - 2) * 2) == border end)
    |> List.first()
  end

  # @spec matching_aspect_ratio_constraint(list: [pos_integer()], aspect_ratio: pos_integer()) :: {pos_integer(), pos_integer()}
  defp matching_aspect_ratio_constraint(list, aspect_ratio) when aspect_ratio > 1 do
    {num, denom} = Float.ratio(aspect_ratio)
    list
    |> Enum.filter(fn {row, column} -> max(row, column) / min(row, column) == num / denom end)
    |> List.first()
  end
  defp matching_aspect_ratio_constraint(list, aspect_ratio) do
    {num, denom} = Float.ratio(aspect_ratio)
    list
    |> Enum.filter(fn {row, column} -> row / column == num / denom end)
    |> List.first()
  end


  # @spec find_by_target(list: [pos_integer()], target: pos_integer()) :: {pos_integer(), pos_integer()}
  defp find_by_target(list, target) do
    set = MapSet.new(list)
    for x <- list,
        rem(target, x) == 0,
        y = div(target, x),
        MapSet.member?(set, y),
        x < y do
      {x, y}
    end
  end


  defp format(aspect_ratio) when aspect_ratio > 1, do: :landscape
  defp format(aspect_ratio) when aspect_ratio < 1, do: :portrait
  defp format(0), do: :square

  defp border_pieces(rows, columns), do: (2 * columns) + (2 * (rows - 2))
  defp inside_pieces(pieces, border_pieces), do: pieces - border_pieces
end
