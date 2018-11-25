defmodule Bob do
  defp shouting?(text) do
    text_chars = String.replace(text, ~r/[^\p{L}]/iu, "") 
    String.length(text_chars) > 0 && String.upcase(text_chars) == text_chars 
  end

  defp question?(text) do String.ends_with?(text, "?") end
  defp empty?(text) do String.length(String.trim(text)) == 0 end

  def hey(input) do
    clean_input = String.trim(input)
    cond do
      empty?(clean_input) -> "Fine. Be that way!" 
      shouting?(clean_input) && question?(clean_input) -> "Calm down, I know what I'm doing!"
      question?(clean_input) -> "Sure."
      shouting?(clean_input) -> "Whoa, chill out!"
      true -> "Whatever."
    end
  end
end
