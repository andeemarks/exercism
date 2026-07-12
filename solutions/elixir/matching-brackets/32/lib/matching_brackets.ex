defmodule MatchingBrackets do
  @doc """
  Checks that all the brackets and braces in the string are matched correctly, and nested correctly
  """
  @spec check_brackets(String.t()) :: boolean
  # def check_brackets(""), do: true
  def check_brackets(str) do
    clean_str =
      str
      |> String.replace(~r/[^\{\}\[\]\(\)]/, "")
      |> replace_brackets()

    String.length(clean_str) == 0
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
