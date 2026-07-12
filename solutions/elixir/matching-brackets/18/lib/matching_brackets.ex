defmodule MatchingBrackets do
  @doc """
  Checks that all the brackets and braces in the string are matched correctly, and nested correctly
  """
  @spec check_brackets(String.t()) :: boolean
  def check_brackets(""), do: true
  def check_brackets(str) do
    clean_str =
      str
      |> String.replace("{}", "")
      |> String.replace("[]", "")
      |> String.replace("()", "")
      |> String.replace(~r/[^\{\}\[\]\(\)]/, "")
    opening_bracket? = clean_str |> String.contains?("[")
    opening_brace? = clean_str |> String.contains?("{")
    matched_brackets? = opening_bracket? and clean_str |> String.match?(~r/\[.*\]/)
    matched_braces? = opening_brace? and clean_str |> String.match?(~r/\{.*\}/)
    if opening_bracket? and not matched_brackets? do
      false
    else
      if opening_brace? and not matched_braces? do
        false
      else
        opening_only = clean_str |> String.replace(~r/[^\[\{\(]/, "")
        closing_only = clean_str |> String.replace(~r/[^\]\}\)]/, "")

        mirror_closing(closing_only) == opening_only
      end
    end
  end

  defp mirror_closing(closing_only) do
    closing_only
    |> String.reverse()
    |> String.replace("}", "{")
    |> String.replace("]", "[")
    |> String.replace(")", "(")

  end
end
