module BookStore
  DISCOUNT = { 1 => 1.0, 2 => 0.95, 3 => 0.90, 4 => 0.80, 5 => 0.75 }

  def self.calculate_price(basket)
    counts = basket.tally.values.sort.reverse

    groups = []
    while counts.any? { |c| c > 0 }
      group_size = counts.count { |c| c > 0 }
      groups << group_size
      counts = counts.map.with_index { |c, i| i < group_size ? c - 1 : c }.sort.reverse
    end

    conversions = [groups.count(5), groups.count(3)].min
    conversions.times do
      groups.delete_at(groups.index(5))
      groups.delete_at(groups.index(3))
      groups.push(4, 4)
    end

    groups.sum { |size| size * 8.0 * DISCOUNT[size] }
  end
end
