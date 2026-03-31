class Darts
  def initialize(x, y)
    distance_from_bullseye = Math.sqrt(x * x + y * y)

    @score = 10
    @score = 5 if distance_from_bullseye > 1
    @score = 1 if distance_from_bullseye > 5
    @score = 0 if distance_from_bullseye > 10
  end

  attr_reader :score
end