defmodule ListOps do
  # Please don't use any external modules (especially List or Enum) in your
  # implementation. The point of this exercise is to create these basic
  # functions yourself. You may use basic Kernel functions (like `Kernel.+/2`
  # for adding numbers), but please do not use Kernel functions for Lists like
  # `++`, `--`, `hd`, `tl`, `in`, and `length`.

  @spec count(list) :: non_neg_integer
  def count([_ | rest]), do: 1 + count(rest)
  def count([]), do: 0

  @spec reverse(list) :: list
  def reverse([]), do: []
  def reverse([head | rest]), do: append(reverse(rest), [head])

  @spec map(list, (any -> any)) :: list
  def map([head | rest], f), do: [f.(head) | map(rest, f)]
  def map([], _f), do: []

  @spec filter(list, (any -> as_boolean(term))) :: list
  def filter([head | rest], f) do
    if f.(head) do
      [head | filter(rest, f)]
    else
      filter(rest, f)
    end
  end
  def filter([], _f), do: []

  @type acc :: any
  @spec foldl(list, acc, (any, acc -> acc)) :: acc
  def foldl([head | rest], acc, f), do: foldl(rest, f.(head, acc), f)
  def foldl([], acc, _f), do: acc

  @spec foldr(list, acc, (any, acc -> acc)) :: acc
  def foldr(l, acc, f), do: reverse(l) |> foldl(acc, f)

  @spec append(list, list) :: list
  def append(a, b), do: foldr(a, b, &[&1 | &2])

  @spec concat([[any]]) :: [any]
  def concat(ll), do: foldr(ll, [], &append/2)
end
