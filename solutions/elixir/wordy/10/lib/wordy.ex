defmodule Wordy do
  @doc """
  Calculate the math problem in the sentence.
  """
  @spec answer(String.t()) :: integer
  def answer(question), do: parse(String.split(question))

  defp parse(["What", "is", number1, operator, number2]) do
    do_operation(operator, parse_numbers(number1, number2))
  end

  defp parse(["What", "is", number1, operator1, number2, operator2, number3]) do
    temp = do_operation(operator1, parse_numbers(number1, number2))
    num3 = parse_number(number3)
    do_operation(operator2, {temp, num3})
  end

  defp parse(["What", "is", number1, operator1, number2, operator2, "by", number3]) do
    temp = do_operation(operator1, parse_numbers(number1, number2))
    num3 = parse_number(number3)
    do_operation(operator2, {temp, num3})
  end

  defp parse(["What", "is", number1, operator, "by", number2]) do
    do_operation(operator, parse_numbers(number1, number2))
  end

  defp parse(["What", "is", number1, operator1, "by", number2, operator2, "by", number3]) do
    temp = do_operation(operator1, parse_numbers(number1, number2))
    num3 = parse_number(number3)
    do_operation(operator2, {temp, num3})
  end

  defp parse(["What", "is", number]), do: parse_number(number)

  defp parse(_), do: raise(ArgumentError)

  defp parse_number(number) do
    number
    |> String.replace("?", "")
    |> String.to_integer()
  end

  defp parse_numbers(number1, number2) do
    {parse_number(number1), parse_number(number2)}
  end

  defp do_operation(operator, {num1, num2}) do
    case operator do
      "plus" -> num1 + num2
      "minus" -> num1 - num2
      "multiplied" -> num1 * num2
      "divided" -> div(num1, num2)
    end
  end
end
