defmodule MatchingBrackets do
  @doc """
  Checks that all the brackets and braces in the string are matched correctly, and nested correctly
  """
  @spec check_brackets(String.t()) :: boolean
  def check_brackets(""), do: true
  def check_brackets(str) do
    clean_str =
      str
      |> replace_brackets()
      |> String.replace(~r/[^\{\}\[\]\(\)]/, "")
    opening_bracket? = clean_str |> String.contains?("[")
    opening_brace? = clean_str |> String.contains?("{")
    matched_brackets? = opening_bracket? and clean_str |> String.match?(~r/\[.*\]/)
    matched_braces? = opening_brace? and clean_str |> String.match?(~r/\{.*\}/)
    opening_only = clean_str |> String.replace(~r/[^\[\{\(]/, "")
    closing_only = clean_str |> String.replace(~r/[^\]\}\)]/, "")
    cond do
      opening_bracket? and not matched_brackets? -> false
      opening_brace? and not matched_braces? -> false
      true -> mirror(closing_only) == opening_only
    end
  end

  defp mirror(closing_only) do
    closing_only
    |> String.reverse()
    |> String.replace("}", "{")
    |> String.replace("]", "[")
    |> String.replace(")", "(")

  end

  defp replace_brackets(current_str) do
    replace_brackets(current_str, "")
  end

  defp replace_brackets(current_str, previous_str) do
    new_str = current_str
    |> String.replace("{}", "")
    |> String.replace("[]", "")
    |> String.replace("()", "")

    if new_str == previous_str do
      new_str
    else
      replace_brackets(new_str, current_str)
    end
  end
end
