defmodule Wordy do
  @doc """
  Calculate the math problem in the sentence.
  """
  @spec answer(String.t()) :: integer
  def answer(question) do
    question
    |> String.replace("divided by", "divided")
    |> String.replace("multiplied by", "multiplied")
    |> String.replace_leading("What is", "")
    |> String.replace_trailing("?", "")
    |> String.split()
    |> parse()
  end

  defp parse([number1, operator1, number2, operator2, number3]) do
    temp = operator1
    |> do_operation(parse_numbers(number1, number2))
    |> Integer.to_string()
    parse([temp, operator2, number3])
  end

  defp parse([number1, operator, number2]) do
    do_operation(operator, parse_numbers(number1, number2))
  end

  defp parse([number]), do: parse_number(number)

  defp parse(_), do: raise(ArgumentError)

  defp parse_number(number), do: number |> String.to_integer()

  defp parse_numbers(number1, number2) do
    {parse_number(number1), parse_number(number2)}
  end

  defp do_operation("plus", {num1, num2}), do: num1 + num2
  defp do_operation("minus", {num1, num2}), do: num1 - num2
  defp do_operation("multiplied", {num1, num2}), do: num1 * num2
  defp do_operation("divided", {num1, num2}), do: div(num1, num2)
end
