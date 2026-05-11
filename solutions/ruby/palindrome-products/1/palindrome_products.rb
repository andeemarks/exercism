class Palindromes
  def initialize(max_factor:, min_factor: 1)
    raise ArgumentError, "min must be <= max" if min_factor > max_factor
    @max_factor = max_factor
    @min_factor = min_factor
  end

  def generate
    @palindromes = []
    (@min_factor..@max_factor).each do |i|
      (@min_factor..@max_factor).each do |j|
        product = i * j
        if palindrome?(product)
          if @palindromes.map(&:value).include?(product)
            existing = @palindromes.find { |p| p.value == product }
            existing.factors << [i, j] if (existing.factors.include?([i, j]) == false) and (existing.factors.include?([j, i]) == false)
          else
            @palindromes << PalindromeProduct.new(product, [[i, j]]) if palindrome?(product)
          end
        end
      end
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