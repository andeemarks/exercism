defmodule RPNCalculator.Exception do
  defmodule DivisionByZeroError do
    defexception message: "division by zero occurred"
  end

  def divide([]), do: raise RPNCalculator.Exception.StackUnderflowError, "when dividing"
  def divide([_x]), do: raise RPNCalculator.Exception.StackUnderflowError, "when dividing"
  def divide([0, _x]), do: raise RPNCalculator.Exception.DivisionByZeroError
  def divide([divisor, dividend]), do: dividend / divisor

  defmodule StackUnderflowError do
    defexception message: "stack underflow occurred"

    @impl true
    def exception(value) do
      case value do
        [] ->
          %StackUnderflowError{}
        _ ->
          %StackUnderflowError{message: "stack underflow occurred, context: " <> value}
      end
    end

  end
end
