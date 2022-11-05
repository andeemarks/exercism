defmodule RunLengthEncoder do
  @doc """
  Generates a string where consecutive elements are represented as a data value and count.
  "AABBBCCCC" => "2A3B4C"
  For this example, assume all input are strings, that are all uppercase letters.
  It should also be able to reconstruct the data into its original form.
  "2A3B4C" => "AABBBCCCC"
  """
  @spec encode(String.t()) :: String.t()
  def encode(string) do
    string
    |> group_runs()
    |> Enum.map_join("", &format_run/1)
  end

  defp group_runs(string) do
    string
    |> String.codepoints()
    |> Enum.chunk_while([], &chunk_fun/2, &after_fun/1)
  end

  defp format_run(run) when length(run) == 1, do: run
  defp format_run(run), do: Integer.to_string(length(run)) <> hd(run)

  defp expand_run(_, length, run), do: String.pad_trailing(run, String.to_integer(length), run)

  defp after_fun([]), do: {:cont, []}
  defp after_fun(acc), do: {:cont, acc, []}
  defp chunk_fun(element, []), do: {:cont, [element]}
  defp chunk_fun(element, acc) when hd(acc) == element, do: {:cont, [element | acc]}
  defp chunk_fun(element, acc), do: {:cont, acc, [element]}

  @spec decode(String.t()) :: String.t()
  def decode(string) do
    Regex.replace(~r/(?<length>[[:digit:]]+)(?<run>.)/, string, &expand_run/3)
  end
end
