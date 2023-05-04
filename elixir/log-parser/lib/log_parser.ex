defmodule LogParser do
  def valid_line?(line) do
    line =~ ~r/^\[(DEBUG|INFO|WARNING|ERROR)\]/
  end

  def split_line(line) do
    Regex.split(~r/<[~*=-]*\>/, line)
  end

  def remove_artifacts(line) do
    Regex.replace(~r/end-of-line\d+/i, line, "")
  end

  def tag_with_user_name(line) do
    result = Regex.named_captures(~r/User\s+(?<user>\S+)\s*/, line)
    format_tag_with_user_name(line, result)
  end

  defp format_tag_with_user_name(line, nil), do: line
  defp format_tag_with_user_name(line, result), do: "[USER] #{Map.get(result, "user")} #{line}"
end
