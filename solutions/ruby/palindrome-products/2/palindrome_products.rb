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
      (@min_factor..@max_factor).each do |i|
        (@min_factor..@max_factor).each do |j|
          product = i * j
          if palindrome?(product)
            if @palindromes.map(&:value).include?(product)
              existing = @palindromes.find { |p| p.value == product }
              existing.factors << [i, j] unless existing.factors.include?([i, j]) || existing.factors.include?([j, i])
            else
              @palindromes << PalindromeProduct.new(product, [[i, j]]) if palindrome?(product)
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