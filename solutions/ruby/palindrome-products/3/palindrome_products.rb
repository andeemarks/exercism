class Palindromes
  @@cache = {}

  def initialize(max_factor:, min_factor: 1)
    raise ArgumentError, "min must be <= max" if min_factor > max_factor
    @max_factor = max_factor
    @min_factor = min_factor
  end

  def generate
    key = [@min_factor, @max_factor]
    if @@cache[key]
      @palindromes = @@cache[key]
    else
      @palindromes = []
      palindromes_hash = {}
      (@min_factor..@max_factor).each do |i|
        (i..@max_factor).each do |j|
          product = i * j
          if palindrome?(product)
            factors_to_add = [[i, j]]
            if palindromes_hash[product]
              existing = palindromes_hash[product]
              factors_to_add.each do |factor_pair|
                existing.factors << factor_pair unless existing.factors.include?(factor_pair)
              end
            else
              @palindromes << PalindromeProduct.new(product, factors_to_add)
              palindromes_hash[product] = @palindromes.last
            end
          end
        end
      end
      @@cache[key] = @palindromes
    end
  end

  def smallest
    @palindromes.min_by(&:value) || PalindromeProduct.new(nil, [])
  end

  def largest
    @palindromes.max_by(&:value) || PalindromeProduct.new(nil, [])
  end
  
  def palindrome?(number)
    str = number.to_s
    str == str.reverse
  end
end

PalindromeProduct = Struct.new(:value, :factors)