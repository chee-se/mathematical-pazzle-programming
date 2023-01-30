#frozen_string_literal: true

# 7 セグメントで、0 から 9 までを 1 回ずつ表示する時、店頭と消灯の切り替えが最も少なくなる順番とその回数を求めよ。

# cf) 7 セグメント LED

# 各数字のセグメントコードは以下の通り。（0: 消灯, 1: 点灯）
# 0: 1111110
# 1: 0110000
# 2: 1101101
# 3: 1111001
# 4: 0110011
# 5: 1011011
# 6: 1011111
# 7: 1110000
# 8: 1111111
# 9: 1111011

module Q38

  # すべての順番で全探索する
  SEGMENT = [
    '1111110'.to_i(2),
    '0110000'.to_i(2),
    '1101101'.to_i(2),
    '1111001'.to_i(2),
    '0110011'.to_i(2),
    '1011011'.to_i(2),
    '1011111'.to_i(2),
    '1110000'.to_i(2),
    '1111111'.to_i(2),
    '1111011'.to_i(2)
  ]

  def self.main
    time = Time.now.to_f
    puts find_lowest_cost_number_order((0..9).to_a).to_s
    puts Time.now.to_f - time
  end

  def self.find_lowest_cost_number_order(remain_numbers = (0..9).to_a, order = [], cost = 0)
    return cost if remain_numbers.empty?

    remain_numbers.map {|n|
      find_lowest_cost_number_order(remain_numbers - [n], order + [n], cost + switch_cost(order.last, n))
    }.min
  end

  @@switch_cost_memo = Array.new(10) {Array.new(10)}
  def self.switch_cost(prev, after)
    return 0 if prev.nil?
    return @@switch_cost_memo[prev][after] unless @@switch_cost_memo[prev][after].nil?

    cost_bi = SEGMENT[prev] ^ SEGMENT[after]
    cost = 0

    loop do
      return @@switch_cost_memo[prev][after] = cost if cost_bi == 0
      cost += cost_bi % 2
      cost_bi /= 2
    end
  end
end

Q38.main
