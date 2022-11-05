defmodule TakeANumber do
  def start() do
    spawn(TakeANumber, :run, [])
  end

  def run(number \\ 0) do
    receive do
      {:report_state, sender}  -> 
        send(sender, number)
        run(number)
      {:take_a_number, sender} -> 
        number = number + 1
        send(sender, number)
        run(number)
      :stop -> nil
      _ -> run(number)
    end

  end
end
