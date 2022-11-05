defmodule BinarySearchTree do
  @type bst_node :: %{data: any, left: bst_node | nil, right: bst_node | nil}

  @doc """
  Create a new Binary Search Tree with root's value as the given 'data'
  """
  @spec new(any) :: bst_node
  def new(data) do
    %{data: data, left: nil, right: nil}
  end

  defp insert_right(tree, data, root, right) when right == nil do
    %{data: root, left: tree.left, right: new(data)}
  end
  defp insert_right(tree, data, root, right) do
    %{data: root, left: tree.left, right: insert(right, data)}
  end

  defp insert(tree, data, root) when data > root do
    insert_right(tree, data, root, tree.right)
  end
  
  defp insert(tree, data, root) when data <= root do
    insert_left(tree, data, root, tree.left)
  end

  defp insert_left(tree, data, root, left) when left == nil do
    %{data: root, left: new(data), right: tree.right}
  end
  defp insert_left(tree, data, root, left) do
    %{data: root, left: insert(left, data), right: tree.right}
  end

  @doc """
  Creates and inserts a node with its value as 'data' into the tree.
  """
  @spec insert(bst_node, any) :: bst_node
  def insert(tree, data) do
    insert(tree, data, tree.data)
  end

  @doc """
  Traverses the Binary Search Tree in order and returns a list of each node's data.
  """
  @spec in_order(bst_node) :: [any]
  def in_order(%{data: data, left: left, right: right}) do
    pre_order(left) ++ [data] ++ pre_order(right)
  end

  def pre_order(nil), do: []
  def pre_order(%{data: data, left: nil, right: nil}), do: [data]
  def pre_order(%{data: data, left: left, right: right}) do
    [data] ++ pre_order(left) ++ pre_order(right)
  end

end
