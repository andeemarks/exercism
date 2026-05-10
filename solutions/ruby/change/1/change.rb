class Change
  ImpossibleCombinationError = Class.new(StandardError)
  NegativeTargetError = Class.new(StandardError)

  def self.generate(coins, target)
    raise NegativeTargetError if target < 0

    coins = coins.sort

    coins_for = Array.new(target + 1)
    coins_for[0] = []

    (1..target).each do |amount|
      coins_for[amount] = fewest_coins_for(amount, coins, coins_for)
    end

    raise ImpossibleCombinationError if coins_for[target].nil?

    coins_for[target].sort
  end

  def self.fewest_coins_for(amount, coins, coins_for)
    best_coin = coins
      .select { |coin| coin <= amount && coins_for[amount - coin] }
      .min_by { |coin| coins_for[amount - coin].length }
    best_coin && coins_for[amount - best_coin] + [best_coin]
  end

  private_class_method :fewest_coins_for
end
