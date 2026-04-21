defmodule BankAccount do
  @moduledoc """
  A bank account that supports access from multiple processes.
  """

  @typedoc """
  An account handle.
  """
  @opaque account :: pid

  @doc """
  Open the bank account, making it available for further operations.
  """
  @spec open() :: account
  def open() do
    Agent.start_link(fn -> {0, :open} end) |> elem(1)
  end

  @doc """
  Close the bank account, making it unavailable for further operations.
  """
  @spec close(account) :: any
  def close(account), do: Agent.update(account, fn acc -> {elem(acc, 0), :closed} end)

  @doc """
  Get the account's balance.
  """
  @spec balance(account) :: integer | {:error, :account_closed}
  def balance(account), do: balance(account, state(account))
  defp balance(account, :open), do: Agent.get(account, fn acc -> elem(acc, 0) end)
  defp balance(_, :closed), do: {:error, :account_closed}

  @doc """
  Add the given amount to the account's balance.
  """
  @spec deposit(account, integer) :: :ok | {:error, :account_closed | :amount_must_be_positive}
  def deposit(_, amount) when amount < 0, do: {:error, :amount_must_be_positive}
  def deposit(account, amount), do: deposit(account, amount, state(account))
  defp deposit(account, amount, :open), do: Agent.update(account, fn acc -> {elem(acc, 0) + amount, :open} end)
  defp deposit(_, _, :closed), do: {:error, :account_closed}

  @doc """
  Subtract the given amount from the account's balance.
  """
  @spec withdraw(account, integer) ::
          :ok | {:error, :account_closed | :amount_must_be_positive | :not_enough_balance}
  def withdraw(_, amount) when amount < 0, do: {:error, :amount_must_be_positive}
  def withdraw(account, amount),do: withdraw(account, amount, state(account))

  defp withdraw(account, amount, :open) do
    withdraw(account, balance(account, :open), amount, :open)
  end
  defp withdraw(_, _, :closed), do: {:error, :account_closed}
  defp withdraw(account, balance, amount, :open) when balance - amount >= 0 do
    Agent.update(account, fn _acc -> {balance - amount, :open} end)
  end
  defp withdraw(_, balance, amount, :open) when balance - amount < 0, do: {:error, :not_enough_balance}

  defp state(account), do: Agent.get(account, fn acc -> elem(acc, 1) end)
end
