class Triangle
  @unique_side_lengths : Set(Float64)

  def initialize(sides : Tuple(Int32, Int32, Int32))
    initialize({sides[0].to_f64, sides[1].to_f64, sides[2].to_f64})
  end

  def initialize(sides : Tuple(Float64, Float64, Float64))
    side_lengths = sides.to_a.sort
    shortest_length = side_lengths[0]

    raise ArgumentError.new if shortest_length == 0
    raise ArgumentError.new if shortest_length + side_lengths[1] < side_lengths[2]

    @unique_side_lengths = Set.new(side_lengths)
  end

  def equilateral? : Bool
    @unique_side_lengths.size == 1
  end

  def isosceles? : Bool
    @unique_side_lengths.size <= 2
  end

  def scalene? : Bool
    @unique_side_lengths.size == 3
  end
end
