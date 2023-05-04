defmodule Triangle do
  @type kind :: :equilateral | :isosceles | :scalene

  @doc """
  Return the kind of triangle of a triangle with 'a', 'b' and 'c' as lengths.
  """
  @spec kind(number, number, number) :: {:ok, kind} | {:error, String.t()}
  def kind(a, b, c) do
    longest_size = Enum.max([a, b, c])
    perimeter = Enum.sum([a, b, c])
    unique_side_count = MapSet.size(MapSet.new([a, b, c]))

    case {a, b, c} do
      {a, b, c} when a <= 0 or b <= 0 or c <= 0 ->
        {:error, "all side lengths must be positive"}

      {_, _, _} when longest_size >= perimeter / 2 ->
        {:error, "side lengths violate triangle inequality"}

      {_, _, _} when unique_side_count == 1 ->
        {:ok, :equilateral}

      {_, _, _} when unique_side_count == 3 ->
        {:ok, :scalene}

      {_, _, _} ->
        {:ok, :isosceles}
    end
  end
end
