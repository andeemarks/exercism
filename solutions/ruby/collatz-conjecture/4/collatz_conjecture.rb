class CollatzConjecture
  def self.steps(n)
    raise ArgumentError unless n > 0

    count = 0
    while n != 1
      count += 1

      n = n.even? ? n / 2 : (n * 3) + 1
    end

    count
  end
end