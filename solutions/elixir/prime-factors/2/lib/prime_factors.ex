defmodule PrimeFactors do
  @spec factors_for(pos_integer) :: [pos_integer]
  def factors_for(1), do: []

  def factors_for(number) do
    limit = :math.sqrt(number) |> trunc()
    primes = PrimeGenerator.generate_primes(limit)

    find_factors([], primes, number)
    |> Enum.sort()
  end

  defp find_factors(factors, [], number) do
    if number > 1, do: [number | factors], else: factors
  end

  defp find_factors(factors, [next_prime | rest], number) do
    if rem(number, next_prime) == 0 do
      find_factors([next_prime | factors], [next_prime | rest], div(number, next_prime))
    else
      find_factors(factors, rest, number)
    end
  end
end

defmodule PrimeGenerator do
  @doc """
  Generates a list of prime numbers up to the given `limit`.
  """
  def generate_primes(limit) when limit < 2, do: []

  def generate_primes(limit) do
    # Create a map where keys are numbers from 2 to limit, all initially marked as true (prime)
    sieve = Map.new(2..limit, fn x -> {x, true} end)
    max_factor = :math.sqrt(limit) |> trunc()

    # Iteratively clear multiples of primes starting from 2
    sieve
    |> run_sieve(2, max_factor, limit)
    |> Stream.filter(fn {_num, is_prime} -> is_prime end)
    |> Stream.map(fn {num, _is_prime} -> num end)
    |> Enum.sort()
  end

  defp run_sieve(sieve, current, max_factor, limit) when current <= max_factor do
    case Map.get(sieve, current) do
      true ->
        # Eliminate all multiples of the current prime number
        updated_sieve = eliminate_multiples(sieve, current * current, current, limit)
        run_sieve(updated_sieve, current + 1, max_factor, limit)

      false ->
        # Skip if the number is already marked as composite
        run_sieve(sieve, current + 1, max_factor, limit)
    end
  end

  defp run_sieve(sieve, _current, _max_factor, _limit), do: sieve

  defp eliminate_multiples(sieve, multiple, step, limit) when multiple <= limit do
    updated_sieve = Map.put(sieve, multiple, false)
    eliminate_multiples(updated_sieve, multiple + step, step, limit)
  end

  defp eliminate_multiples(sieve, _multiple, _step, _limit), do: sieve
end
