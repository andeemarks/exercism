defmodule Grep do
  @spec grep(String.t(), [String.t()], [String.t()]) :: String.t()

  def grep(pattern, flags, [file]) do
    pattern
    |> grep_file(flags, file)
    |> format()
  end

  def grep(pattern, flags, files) do
    files
    |> Enum.map(&grep_file(pattern, flags, &1, true))
    |> Enum.filter(&(String.length(&1) > 0))
    |> post_process()
  end

  defp format(""), do: ""
  defp format(results), do: results |> String.trim() |> Kernel.<>("\n")

  defp post_process([]), do: ""
  defp post_process(results), do: results |> Enum.join("\n") |> String.trim() |> Kernel.<>("\n")

  defp grep_file(pattern, flags, file, multifile? \\ false) do
    {:ok, lines} = File.read(file)

    flags = reconcile_flags(flags)
    Enum.with_index(String.split(lines, "\n"), 1)
    |> Enum.filter(fn {line, _} -> line_matches?(line, pattern, flags) end)
    |> formatter(flags, file, multifile?)
  end

  defp reconcile_flags(flags) do
    if("-l" in flags and "-n" in flags, do: List.delete(flags, "-n"), else: flags)
  end

  defp line_matches?(line, pattern, flags) do
    match? = cond do
      "-i" in flags -> 
        String.match?(line, ~r/#{pattern}/i)
      "-x" in flags -> 
        String.match?(line, ~r/^#{pattern}$/)
      true -> 
        String.match?(line, ~r/#{pattern}/)
    end

    if "-v" in flags, do: !match?, else: match?
  end

  defp formatter([], _, _, _), do: ""
  defp formatter(lines, flags, filename, multifile?) do
    file_header = if(multifile?, do: "#{filename}:", else: "")
    results = cond do
      "-n" in flags ->
        Enum.map(lines, fn {line, number} -> "#{file_header}#{Integer.to_string(number)}:#{line}" end)
      "-l" in flags ->
        [filename]
      true ->
        Enum.map(lines, fn {line, _} -> if(line == "", do: "", else: "#{file_header}#{line}") end)
    end

    results
    |> Enum.join("\n")
    |> String.trim()
  end
end
