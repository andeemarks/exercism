defmodule TopSecret do
  def to_ast(string) do
    {:ok, ast} = Code.string_to_quoted(string)

    ast
  end

  def decode_secret_message_part({node, _, fn_definition} = ast, acc)
      when node in [:def, :defp] do
    {ast, [parse_function_name(fn_definition) | acc]}
  end

  def decode_secret_message_part(ast, acc), do: {ast, acc}

  defp parse_function_name(fn_definition) do
    case hd(fn_definition) do
      {:when, _, fn_body} -> parse_function_name(fn_body)
      {fn_name, _, fn_args} -> String.slice(Atom.to_string(fn_name), 0, arity(fn_args))
    end
  end

  defp arity(nil), do: 0
  defp arity(fn_args), do: length(fn_args)

  def decode_secret_message(code) do
    code
    |> to_ast
    |> decode_message_fragment
    |> Enum.join()
  end

  defp decode_message_fragment({:defmodule, _, block_body}) do
    {:do, module_body} = block_body |> tl |> hd |> hd

    decode_message_fragment(module_body)
  end

  defp decode_message_fragment({:__block__, _, block_body}) do
    parse_block_body(block_body)
  end

  defp decode_message_fragment(module_body) when is_tuple(module_body) do
    module_body
    |> decode_secret_message_part([])
    |> elem(1)
  end

  defp parse_block_body(block_body) do
    Enum.map(block_body, &parse_block_item/1)
  end

  defp parse_block_item({:defmodule, _, _} = block_item) do
    decode_message_fragment(block_item)
  end

  defp parse_block_item(block_item) do
    block_item
    |> decode_secret_message_part("")
    |> elem(1)
  end
end
