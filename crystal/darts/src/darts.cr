module Darts
  def self.score(x : Number, y : Number) : Number
    distance_from_middle = Math.hypot(x, y)

    case distance_from_middle
    when .> 10 then 0
    when .> 5  then 1
    when .> 1  then 5
    else            10
    end
  end
end
