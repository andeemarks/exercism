defmodule RationalNumbers do
  @type rational :: {integer, integer}

  defp extract(a, b) do
    a1 = elem(a, 0)
    b1 = elem(a, 1)
    a2 = elem(b, 0)
    b2 = elem(b, 1)

    [a1, b1, a2, b2]
  end

  @doc """
  Add two rational numbers
  """
  @spec add(a :: rational, b :: rational) :: rational
  def add(a, b) do
    [a1|[b1|[a2|[b2]]]] = extract(a, b)

    {(a1 * b2 + a2 * b1), (b1 * b2)}
  end

  @doc """
  Subtract two rational numbers
  """
  @spec subtract(a :: rational, b :: rational) :: rational
  def subtract(a, b) do
    [a1|[b1|[a2|[b2]]]] = extract(a, b)

    {(a1 * b2 - a2 * b1), (b1 * b2)}
  end

  @doc """
  Multiply two rational numbers
  """
  @spec multiply(a :: rational, b :: rational) :: rational
  def multiply(a, b) do
    [a1|[b1|[a2|[b2]]]] = extract(a, b)

    {(a1 * a2), (b1 * b2)}
  end

  @doc """
  Divide two rational numbers
  """
  @spec divide_by(num :: rational, den :: rational) :: rational
  def divide_by(num, den) do
    [a1|[b1|[a2|[b2]]]] = extract(num, den)

    {(a1 * b2), (a2 * b1)}
  end

  @doc """
  Absolute value of a rational number
  """
  @spec abs(a :: rational) :: rational
  def abs(a) do
  end

  @doc """
  Exponentiation of a rational number by an integer
  """
  @spec pow_rational(a :: rational, n :: integer) :: rational
  def pow_rational(a, n) do
  end

  @doc """
  Exponentiation of a real number by a rational number
  """
  @spec pow_real(x :: integer, n :: rational) :: float
  def pow_real(x, n) do
  end

  @doc """
  Reduce a rational number to its lowest terms
  """
  @spec reduce(a :: rational) :: rational
  def reduce(a) do
  end
end