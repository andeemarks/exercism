defmodule TopSecret do
  def to_ast(string) do
    elem(Code.string_to_quoted(string, []), 1)
  end

  def decode_secret_message_part(ast, acc) do
    operation = elem(ast, 0)
    decode(operation, ast, acc)
  end

  defp format_fn_name(_, fn_arity) when fn_arity == 0 do
    ""
  end

  defp format_fn_name(fn_name, fn_arity) do
    String.slice(Atom.to_string(fn_name), 0..fn_arity - 1)
  end

  defp extract_fn_arity(ast) do
    ast |> elem(2) |> hd |> elem(2) |> length
  end

  defp extract_fn_name(ast) do
    fn_node = ast |> elem(2) |> hd
    fn_name = fn_node |> elem(0)
    if fn_name == :when do
      fn_arity = try do
        extract_fn_arity(fn_node)
      rescue
        ArgumentError -> 0
      end
      format_fn_name(fn_node |> elem(2) |> hd |> elem(0), fn_arity)
    else
      fn_arity = try do
        extract_fn_arity(ast)
      rescue
        ArgumentError -> 0
      end
      format_fn_name(fn_name, fn_arity)
    end
  end

  defp decode(operation, ast, acc) when operation in [:defmodule] do
    ast = ast |> elem(2) |> tl |> hd |> hd |> elem(1)
    operation = ast |> elem(0)
    decode(operation, ast, acc)
  end

  defp decode(operation, ast, acc) when operation in [:def, :defp] do
    fn_name = extract_fn_name(ast)

    IO.inspect(fn_name)
    {ast, [fn_name | acc]}
  end

  # defp decode(operation, ast, acc) when operation in [:defmodule] do
  #   raise(RuntimeError, "unimplemented")
  # end

  defp decode(_, ast, acc) do
    {ast, acc}
  end

  def decode_secret_message(string) do
    elem(decode_secret_message_part(to_ast(string), []), 1)
  end
end
