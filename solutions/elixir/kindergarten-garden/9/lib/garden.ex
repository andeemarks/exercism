defmodule Garden do
  @seed_lookup %{"V" => :violets, "C" => :clover, "R" => :radishes, "G" => :grass}

  @doc """
    Accepts a string representing the arrangement of cups on a windowsill and a
    list with names of students in the class. The student names list does not
    have to be in alphabetical order.

    It decodes that string into the various gardens for each student and returns
    that information in a map.
  """

  @spec info(String.t(), list) :: map
  def info(info_string, student_names \\ [:alice, :bob, :charlie, :david, :eve, :fred, :ginny, :harriet, :ileana, :joseph, :kincaid, :larry]) do
    [row1_seeds, row2_seeds] = split_rows(info_string)

    student_names
    |> Enum.sort()
    |> Enum.with_index()
    |> Map.new(fn {name, student_pos} -> {name, student_seeds(Enum.at(row1_seeds, student_pos), Enum.at(row2_seeds, student_pos))} end)
  end

  defp split_rows(info_string) do
    [row1, row2] = String.split(info_string)
    row1_seeds = row1 |> String.graphemes() |> Enum.chunk_every(2)
    row2_seeds = row2 |> String.graphemes() |> Enum.chunk_every(2)

    [row1_seeds, row2_seeds]
  end

  @spec student_seeds(String.t(), String.t()) :: map
  defp student_seeds(nil, nil), do: {}
  defp student_seeds(row1_seeds, row2_seeds) do
    {
      @seed_lookup[Enum.at(row1_seeds, 0)],
      @seed_lookup[Enum.at(row1_seeds, 1)],
      @seed_lookup[Enum.at(row2_seeds, 0)],
      @seed_lookup[Enum.at(row2_seeds, 1)],
    }
    |> Tuple.to_list()
    |> Enum.reject(&is_nil/1)
    |> List.to_tuple()
  end
end
