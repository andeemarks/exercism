module BookStore
  DISCOUNT = { 1 => 1.0, 2 => 0.95, 3 => 0.90, 4 => 0.80, 5 => 0.75 }

  def self.calculate_price(basket)
    groups = optimize_groups(build_groups(basket.tally.values.sort.reverse))
    groups.sum { |size| size * 8.0 * DISCOUNT[size] }
  end

  def self.build_groups(counts)
    groups = []
    while counts.any? { |c| c > 0 }
      group_size = counts.count { |c| c > 0 }
      groups << group_size
      group_size.times { |i| counts[i] -= 1 }
      counts.sort!.reverse!
    end
    groups
  end

  def self.optimize_groups(groups)
    conversions = [groups.count(5), groups.count(3)].min
    conversions.times do
      groups.delete_at(groups.index(5))
      groups.delete_at(groups.index(3))
      groups.push(4, 4)
    end
    groups
  end

  private_class_method :build_groups, :optimize_groups
end
