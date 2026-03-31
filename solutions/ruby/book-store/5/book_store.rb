module BookStore
  DISCOUNT = { 1 => 1.0, 2 => 0.95, 3 => 0.90, 4 => 0.80, 5 => 0.75 }
  SUBOPTIMAL_PAIR = [5, 3].freeze
  OPTIMAL_PAIR    = [4, 4].freeze

  def self.calculate_price(basket)
    groups = optimize_groups(build_groups(basket.tally.values.sort.reverse))
    groups.sum { |size| size * 8.0 * DISCOUNT[size] }
  end

  def self.build_groups(sorted_counts)
    groups = []
    while sorted_counts.any? { |c| c > 0 }
      distinct_titles = sorted_counts.count { |c| c > 0 }
      groups << distinct_titles
      sorted_counts.each_index { |i| sorted_counts[i] -= 1 if sorted_counts[i] > 0 }
    end
    groups
  end

  def self.optimize_groups(groups)
    conversions = SUBOPTIMAL_PAIR.map { |size| groups.count(size) }.min
    conversions.times do
      SUBOPTIMAL_PAIR.each { |size| groups.delete_at(groups.index(size)) }
      groups.push(*OPTIMAL_PAIR)
    end
    groups
  end

  private_class_method :build_groups, :optimize_groups
end
