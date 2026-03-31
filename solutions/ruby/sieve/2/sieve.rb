class Sieve
  def initialize(n)
    numbers = (2..n).to_a
    @primes = []
    numbers.each do |number|
      next if number.zero?
      @primes << number
      (number * number..n).step(number) { |j| numbers[j - 2] = 0 }
    end
  end

  attr_reader :primes
end