defmodule BasketballWebsite do
  def extract_from_path(data, path) do
    [first | rest] = String.split(path, ".")
    extract(data[first], rest)
  end

  defp extract(match, [first | rest]) when is_map(match) do
    extract(match[first], rest)
  end
  defp extract(match, _), do: match

  def get_in_path(data, path) do
    get_in(data, String.split(path, "."))
  end
end
