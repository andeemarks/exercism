class PrimeFactors
  def self.of(n)
    factors = []

    return factors if n == 1

    divisor = 2
    while divisor <= n  do
      while n % divisor == 0 do
        n /= divisor
        factors << divisor
      end
      divisor += 1
    end

    factors
  end
end