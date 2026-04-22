defmodule Garden do
  @doc """
    Accepts a string representing the arrangement of cups on a windowsill and a
    list with names of students in the class. The student names list does not
    have to be in alphabetical order.

    It decodes that string into the various gardens for each student and returns
    that information in a map.
  """

  @spec info(String.t(), list) :: map
  def info(info_string, student_names \\ [:alice, :bob, :charlie, :david, :eve, :fred, :ginny, :harriet, :ileana, :joseph, :kincaid, :larry]) do
    [row1, row2] = String.split(info_string)

    student_names
    |> Enum.sort()
    |> Enum.with_index()
    |> Map.new(fn {name, i} -> {name, student_seeds(row1, row2, i*2)} end)
  end

  @spec student_seeds(String.t(), String.t(), Integer) :: map
  defp student_seeds(row1, row2, i) do
    seeds = %{"V" => :violets, "C" => :clover, "R" => :radishes, "G" => :grass}
    {
      seeds[String.at(row1, i)], seeds[String.at(row1, i+1)], seeds[String.at(row2, i)], seeds[String.at(row2, i+1)]
    }
    |> Tuple.to_list()
    |> Enum.reject(&is_nil/1)
    |> List.to_tuple()
  end
end
