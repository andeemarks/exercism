defmodule RationalNumbers do
  @type rational :: {integer, integer}

  defp additive_inverse?(a1, a2), do: a1 == a2 * -1
  defp subtractive_inverse?(a1, b1, a2, b2), do: a1 == a2 && b1 == b2

  @doc """
  Add two rational numbers
  """
  @spec add(a :: rational, b :: rational) :: rational
  def add({a1, b1}, {a2, b2}) do
    cond do
      additive_inverse?(a1, a2) -> {0, 1}
      true -> {a1 * b2 + a2 * b1, b1 * b2}
    end
  end

  @doc """
  Subtract two rational numbers
  """
  @spec subtract(a :: rational, b :: rational) :: rational
  def subtract({a1, b1}, {a2, b2}) do
    cond do
      subtractive_inverse?(a1, b1, a2, b2) -> {0, 1}
      true -> {a1 * b2 - a2 * b1, b1 * b2}
    end
  end

  @doc """
  Multiply two rational numbers
  """
  @spec multiply(a :: rational, b :: rational) :: rational
  def multiply({a1, b1}, {a2, b2}) do
    reduce(a1 * a2, b1 * b2)
  end

  @doc """
  Divide two rational numbers
  """
  @spec divide_by(num :: rational, den :: rational) :: rational
  def divide_by({a1, b1}, {a2, b2}) do
    reduce(a1 * b2, a2 * b1)
  end

  @doc """
  Absolute value of a rational number
  """
  @spec abs(a :: rational) :: rational
  def abs({a1, b1}) do
    reduce(Kernel.abs(a1), Kernel.abs(b1))
  end

  @doc """
  Exponentiation of a rational number by an integer
  """
  @spec pow_rational(a :: rational, n :: integer) :: rational
  def pow_rational({a1, b1}, n) when n > 0 do
    reduce(Integer.pow(a1, n), Integer.pow(b1, n))
  end

  def pow_rational({a1, b1}, n) when n < 0 do
    pow_rational({b1, a1}, -n)
  end

  def pow_rational(_, 0), do: {1, 1}

  @doc """
  Exponentiation of a real number by a rational number
  """
  @spec pow_real(x :: integer, n :: rational) :: float
  def pow_real(x, {a1, b1}) do
    :math.pow(x, a1 / b1)
  end

  @doc """
  Reduce a rational number to its lowest terms
  """
  @spec reduce(a :: rational) :: rational
  def reduce({a1, b1}) do
    reduce(a1, b1)
  end

  defp reduce(r1, r2) when r2 < 0, do: reduce(r1 * -1, r2 * -1)

  defp reduce(r1, r2) do
    {trunc(r1 / Integer.gcd(r1, r2)), trunc(r2 / Integer.gcd(r1, r2))}
  end
end
