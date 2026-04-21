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
    elem(Agent.start_link(fn -> {0, :open} end), 1)
  end

  @doc """
  Close the bank account, making it unavailable for further operations.
  """
  @spec close(account) :: any
  def close(account) do
    Agent.update(account, fn acc -> {elem(acc, 0), :closed} end)
  end

  @doc """
  Get the account's balance.
  """
  @spec balance(account) :: integer | {:error, :account_closed}
  def balance(account) do
    state = Agent.get(account, fn acc -> elem(acc, 1) end)
    balance(account, state)
  end

  def balance(account, :open) do
    Agent.get(account, fn acc -> elem(acc, 0) end)
  end

  def balance(_, :closed) do
    {:error, :account_closed}
  end

  @doc """
  Add the given amount to the account's balance.
  """
  @spec deposit(account, integer) :: :ok | {:error, :account_closed | :amount_must_be_positive}
  def deposit(account, amount) when amount < 0 do
    {:error, :amount_must_be_positive}
  end
  def deposit(account, amount) do
    state = Agent.get(account, fn acc -> elem(acc, 1) end)
    deposit(account, amount, state)
  end

  def deposit(account, amount, :open) do
    Agent.update(account, fn acc -> {elem(acc, 0) + amount, :open} end)
    :ok
  end

  def deposit(_, _, :closed) do
    {:error, :account_closed}
  end

  @doc """
  Subtract the given amount from the account's balance.
  """
  @spec withdraw(account, integer) ::
          :ok | {:error, :account_closed | :amount_must_be_positive | :not_enough_balance}
  def withdraw(account, amount) when amount < 0 do
    {:error, :amount_must_be_positive}
  end

  def withdraw(account, amount) do
    state = Agent.get(account, fn acc -> elem(acc, 1) end)
    withdraw(account, amount, state)
  end

  defp withdraw(account, amount, :open) do
    balance = balance(account, :open)
    withdraw(account, balance, amount, :open)
  end

  defp withdraw(_, _, :closed) do
    {:error, :account_closed}
  end

  defp withdraw(account, balance, amount, :open) when balance - amount >= 0 do
    Agent.update(account, fn _acc -> {balance - amount, :open} end)
    :ok
  end

  defp withdraw(_, balance, amount, :open) when balance - amount < 0 do
    {:error, :not_enough_balance}
  end
end
