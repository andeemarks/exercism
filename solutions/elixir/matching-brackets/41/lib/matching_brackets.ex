defmodule MatchingBrackets do
  @doc """
  Checks that all the brackets and braces in the string are matched correctly, and nested correctly
  """
  @spec check_brackets(String.t()) :: boolean
  def check_brackets(str) do
    # clean_str =
      str
      |> String.replace(~r/[^\{\}\[\]\(\)]/, "")
      |> replace_brackets()
      |> String.length()
      |> Kernel.==(0)

    # String.length(clean_str) == 0
  end

  defp replace_brackets(current), do: replace_brackets(current, "")
  defp replace_brackets(current, previous) when current == previous, do: current
  defp replace_brackets(current, _) do
    current
    |> String.replace("{}", "")
    |> String.replace("[]", "")
    |> String.replace("()", "")
    |> replace_brackets(current)
  end
end
