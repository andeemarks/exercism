defmodule MatchingBrackets do
  @doc """
  Checks that all the brackets and braces in the string are matched correctly, and nested correctly
  """
  @spec check_brackets(String.t()) :: boolean
  def check_brackets(""), do: true
  def check_brackets(str) do
    clean_str = str |> String.replace(~r/[^{}\[\]\(\)]/, "") |> String.replace("{}", "") |> String.replace("[]", "") |> String.replace("[]", "")
    opening_bracket? = clean_str |> String.contains?("[")
    opening_brace? = clean_str |> String.contains?("{")
    opening_paren? = clean_str |> String.contains?("(")
    closing_bracket? = clean_str |> String.contains?("]")
    closing_brace? = clean_str |> String.contains?("}")
    closing_paren? = clean_str |> String.contains?(")")
    matched_brackets? = opening_bracket? and clean_str |> String.match?(~r/\[.*\]/)
    matched_braces? = opening_brace? and clean_str |> String.match?(~r/\{.*\}/)
    matched_parens? = opening_paren? and clean_str |> String.match?(~r/\(.*\)/)
    opening_bracket_only? = opening_bracket? and not closing_bracket?
    opening_brace_only? = opening_brace? and not closing_brace?
    opening_paren_only? = opening_paren? and not closing_paren?
    unmatched? = rem(String.length(clean_str), 2) != 0
    if opening_bracket? and not matched_brackets? do
      false
    else
      if opening_brace? and not matched_braces? do
        false
      else
        if opening_paren? and not matched_parens? do
          false
        else
          if opening_bracket_only? do
            false
          else
            if opening_brace_only? do
              false
            else
              if opening_paren_only? do
                false
              else
                if unmatched? do
                  false
                else
                  # clean_str_no_inner = clean_str |> String.replace("{}", "") |> String.replace("[]", "") |> String.replace("[]", "")
                  opening_only = clean_str |> String.replace(~r/[^\[\{\(]/, "")
                  closing_only = clean_str |> String.replace(~r/[^\]\}\)]/, "")
                  foo = closing_only
                  |> String.reverse()
                  |> String.replace("}", "{")
                  |> String.replace("]", "[")
                  |> String.replace(")", "(")

                  # IO.puts("str: #{str}")
                  # IO.puts("clean_str: #{clean_str_no_inner}")
                  # IO.inspect(opening_only, label: "opening_only")
                  # IO.inspect(foo, label: "foo")
                  foo == opening_only
                end
              end
            end
          end
        end
      end
    end
  end
end
