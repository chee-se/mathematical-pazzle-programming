#frozen_string_literal: true

# 左右6個ずつ、計12個の穴に靴紐を通す。
# 靴紐の交点が最も多くなる通し方の交点はいくつになるか。
# だたし、靴紐の最初と最後の穴は左右の一番上の穴とする

module Q25

  # 計算量はO(n!)
  # 安くはないがn = 10!なら許容範囲内と見る。
  # 1  21
  # 2  22
  # 3  23
  # 4  24
  # 5  25
  # 6  26

  N = 12
  HOLES = [2, 3, 4, 5, 6, 22, 23, 24, 25, 26]
  HEAD, TAIL = [1], [21]

  def self.main
    max_order = HOLES.permutation(10).max_by do |hole_order|
      count_x(HEAD + hole_order + TAIL)
    end
    puts [max_order, count_x(HEAD + max_order + TAIL)].to_s
  end

  def self.count_x(hole_order)
    line = hole_order.each_cons(2).filter_map {|a, b| a > b ? [a, b] : [b, a] if (a - b).abs > 10}
    line.combination(2).count do |(a1, b1), (a2, b2)|
      (a1 - a2) * (b1 - b2) < 0
    end
  end
end

Q25.main
