class Sieve
  def initialize(n)
    numbers = (2..n).to_a
    @primes = []
    numbers.each_with_index do |number, i|
      if number != 0
        @primes << number
        for j in number..n do
          if j <= numbers.length
            if numbers[j-1] % number == 0
              numbers[j-1] = 0 
            end
          end
        end
      end
    end
  end

  attr_reader :primes
end