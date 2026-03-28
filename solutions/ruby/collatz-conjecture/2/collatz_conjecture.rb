class CollatzConjecture
  def self.steps(n)
    raise ArgumentError unless n > 0

    count = 0
    while n != 1
      count += 1

      if n % 2 == 0 then
        n /= 2
      else
        n = (n * 3) + 1
      end
    end

    count
  end
end