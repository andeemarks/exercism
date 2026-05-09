class Triangle
  def initialize(sides)
    @sides = sides
    largest_side = @sides.max
    sum_of_other_sides = @sides.reduce(:+) - largest_side
    @is_degenerate = largest_side >= sum_of_other_sides
    @unique_sides_count = @sides.uniq.size
  end

  def equilateral?
    return @unique_sides_count == 1 && @sides.first > 0
  end

  def isosceles?
    return !@is_degenerate && @unique_sides_count <= 2
  end

  def scalene?
    return !@is_degenerate && @unique_sides_count == 3
  end
end