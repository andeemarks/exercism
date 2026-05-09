class Triangle
  def initialize(sides)
    @sides = sides
    largest_side = @sides.max
    sum_of_other_sides = @sides.reduce(:+) - largest_side
    @is_degenerate = largest_side >= sum_of_other_sides
  end

  def equilateral?
    return @sides.uniq.size == 1 && @sides.first > 0
  end

  def isosceles?
    return false if @is_degenerate

    return @sides.uniq.size <= 2
  end

  def scalene?
    return false if @is_degenerate

    return @sides.uniq.size == 3
  end
end