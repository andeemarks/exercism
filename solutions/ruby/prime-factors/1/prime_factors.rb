class PrimeFactors
  def self.of(n)
    factors = []

    return factors if n == 1

    divisor = 2
    while divisor <= n  do
      while n % divisor == 0 && n > 1 do
        n /= divisor
        factors << divisor
      end
      divisor += 1
    end

    factors
  end

  def self.is_prime?(n)
    true
  end
end