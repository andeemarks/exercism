class ListOps
  def self.arrays(ary)
    size = 0
    ary.each do |a|
      size += 1
    end

    size
  end

  def self.reverser(ary)
    reversed = []
    ary.reverse_each do |a|
      reversed << a
    end

    reversed
  end

  def self.concatter(ary1, ary2)
    ary2.each do |a|
      ary1 << a
    end
    
    ary1
  end

  def self.mapper(ary, &block)
    mapped = []
    ary.each do |a|
      if block
        mapped << block.call(a)
      else
        mapped << a
      end
    end

    mapped
    
  end

  def self.filterer(ary, &block)
    filtered = []
    ary.each do |a|
      if block
        if block.call(a)
          filtered << a
        end
      end
    end

    filtered
    
  end

  def self.sum_reducer(ary)
    sum = 0
    ary.each do |a|
      sum += a
    end
    
    sum
  end

  def self.reduce(ary, accumulator, &block)
    ary.each do |a|
      accumulator = block.call(accumulator, a)
    end
    
  end

  def self.factorial_reducer(ary)
    sum = 1
    ary.each do |a|
      sum *= a
    end
    
    sum
  end
end