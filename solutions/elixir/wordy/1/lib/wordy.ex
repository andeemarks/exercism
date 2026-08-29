defmodule Wordy do
  @doc """
  Calculate the math problem in the sentence.
  """
  @spec answer(String.t()) :: integer
  def answer(question) do
    parse(String.split(question))
  end

  def parse(["What", "is", number1, operator, number2]) do
    {num1, num2} = parse_numbers(number1, number2)
    case operator do
      "plus" -> num1 + num2
      "minus" -> num1 - num2
    end
  end

  def parse(["What", "is", number1, operator1, number2, operator2, number3]) do
    {num1, num2} = parse_numbers(number1, number2)
    temp = case operator1 do
      "plus" -> num1 + num2
      "minus" -> num1 - num2
    end
    num3 = parse_number(number3)
    case operator2 do
      "plus" -> temp + num3
      "minus" -> temp - num3
    end
  end

  def parse(["What", "is", number1, operator1, number2, operator2, "by", number3]) do
    {num1, num2} = parse_numbers(number1, number2)
    temp = case operator1 do
      "plus" -> num1 + num2
      "minus" -> num1 - num2
    end
    num3 = parse_number(number3)
    case operator2 do
      "multiplied" -> temp * num3
      "divided" -> div(temp, num3)
    end
  end

  def parse(["What", "is", number1, operator, "by", number2]) do
    {num1, num2} = parse_numbers(number1, number2)
    case operator do
      "multiplied" -> num1 * num2
      "divided" -> div(num1, num2)
    end
  end

  def parse(["What", "is", number1, operator1, "by", number2, operator2, "by", number3]) do
    {num1, num2} = parse_numbers(number1, number2)
    temp = case operator1 do
      "multiplied" -> num1 * num2
      "divided" -> div(num1, num2)
    end
    num3 = parse_number(number3)
    case operator2 do
      "multiplied" -> temp * num3
      "divided" -> div(temp, num3)
    end
  end

  def parse(["What", "is", number]) do
    parse_number(number)
  end

  def parse(_), do: raise(ArgumentError)

  def parse_number(number) do
    number
    |> String.replace("?", "")
    |> String.to_integer()
  end

  def parse_numbers(number1, number2) do
    num1 = parse_number(number1)
    num2 = parse_number(number2)
    {num1, num2}
  end
end
