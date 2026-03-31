class Darts
  def initialize(x, y)
    distance_squared = x * x + y * y

    @score = if distance_squared > 100 then 0
             elsif distance_squared > 25  then 1
             elsif distance_squared > 1   then 5
             else                              10
             end
  end

  attr_reader :score
end