defmodule SecretHandshake do
  @doc """
  Determine the actions of a secret handshake based on the binary
  representation of the given `code`.

  If the following bits are set, include the corresponding action in your list
  of commands, in order from lowest to highest.

  1 = wink
  10 = double blink
  100 = close your eyes
  1000 = jump

  10000 = Reverse the order of the operations in the secret handshake
  """
  @spec commands(code :: integer) :: list(String.t())
  def commands(code) when code >= 32, do: []
  def commands(code) when code >= 16, do: find_action([], code - 16) |> Enum.reverse()
  def commands(code), do: find_action([], code)

  defp find_action(actions, 0), do: actions
  defp find_action(actions, 1), do: ["wink" | actions]
  defp find_action(actions, 2), do: ["double blink" | actions]
  defp find_action(actions, 4), do: ["close your eyes" | actions]
  defp find_action(actions, 8), do: ["jump" | actions]
  defp find_action(actions, code) when code > 8 do
    find_action(actions, code - 8) ++ find_action(actions, 8)
  end
  defp find_action(actions, code) when code > 4 do
    find_action(actions, code - 4) ++ find_action(actions, 4)
  end
  defp find_action(actions, code) when code > 2 do
    find_action(actions, code - 2) ++ find_action(actions, 2)
  end
end
