#frozen_string_literal: true

# 1000円を両替した場合の硬貨の組み合わせが何通りか求めよ。
# ただし、使用可能な硬化は、10円、50円、100円、500円のみ、
# 釣り銭の枚数は15枚以下とする。

module Q5

  AMOUNT = 1000
  COIN_KINDS = [500, 100, 50, 10].freeze
  MAX_COINS = 15

  def self.main
    puts self.count_excachage_pattern(AMOUNT, COIN_KINDS, MAX_COINS, 0)
  end


  def self.count_excachage_pattern(amount, coin_kinds, coin_capacity, pattern)
    return pattern if amount == 0 || coin_kinds.empty?

    next_coin_kinds = coin_kinds.dup
    new_coin = next_coin_kinds.shift

    # amount を超えない範囲で、最大硬貨の最大枚数でを賄う
    new_coin_num = amount / new_coin
    return pattern if new_coin_num > coin_capacity

    pattern += 1 if amount == new_coin * new_coin_num

    # 最大硬貨を１ずつ枚減らして下位硬貨で賄わせる
    new_coin_num.downto(0) {|n|
      next_amount = amount - new_coin * n
      next_coin_capacity = coin_capacity - n
      pattern += count_excachage_pattern(next_amount, next_coin_kinds, next_coin_capacity, 0)
    }

    pattern
  end
end

Q5.main
