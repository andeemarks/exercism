defmodule ComplexNumbers do
  import Kernel, except: [div: 2]
  @typedoc """
  In this module, complex numbers are represented as a tuple-pair containing the real and
  imaginary parts.
  For example, the real number `1` is `{1, 0}`, the imaginary number `i` is `{0, 1}` and
  the complex number `4+3i` is `{4, 3}'.
  """
  @type complex :: {number, number}

  @doc """
  Return the real part of a complex number
  """
  @spec real(a :: complex) :: number
  def real({r, _}) do
    r
  end

  @doc """
  Return the imaginary part of a complex number
  """
  @spec imaginary(a :: complex) :: number
  def imaginary({_, i}) do
    i
  end

  @doc """
  Multiply two complex numbers, or a real and a complex number
  """
  @spec mul(a :: complex | number, b :: complex | number) :: complex
  def mul(c, r) when is_number(r), do: mul(c, {r, 0})
  def mul(r, c) when is_number(r), do: mul(c, {r, 0})
  def mul({a, b}, {c, d}) do
    {a * c - b * d, b * c + a * d}
  end

  @doc """
  Add two complex numbers, or a real and a complex number
  """
  @spec add(a :: complex | number, b :: complex | number) :: complex
  def add(r, c) when is_number(r), do: add(c, {r, 0})
  def add(c, r) when is_number(r), do: add(c, {r, 0})
  def add({a, b}, {c, d}) do
    {a + c, b + d}
  end

  @doc """
  Subtract two complex numbers, or a real and a complex number
  """
  @spec sub(a :: complex | number, b :: complex | number) :: complex
  def sub(r, c) when is_number(r), do: sub({r, 0}, c)
  def sub(c, r) when is_number(r), do: sub(c, {r, 0})
  def sub({a, b}, {c, d}) do
    {a - c, b - d}
  end

  @doc """
  Divide two complex numbers, or a real and a complex number
  """
  @spec div(a :: complex | number, b :: complex | number) :: complex
  def div(r, c) when is_number(r), do: div({r, 0}, c)
  def div(c, r) when is_number(r), do: div(c, {r, 0})
  def div({a, b}, {c, d}) do
    denom = (c ** 2 + d ** 2)
    {(a * c + b * d) / denom, (b * c - a * d) / denom}
  end

  @doc """
  Absolute value of a complex number
  """
  @spec abs(a :: complex) :: number
  def abs({a, b}) do
    :math.sqrt(a ** 2 + b ** 2)
  end

  @doc """
  Conjugate of a complex number
  """
  @spec conjugate(a :: complex) :: complex
  def conjugate({a, b}) do
    {a,  -b}
  end

  @doc """
  Exponential of a complex number
  """
  @spec exp(a :: complex) :: complex
  def exp({a, b}) do
    r = :math.exp(a)
    {r * :math.cos(b), r * :math.sin(b)}
  end
end
