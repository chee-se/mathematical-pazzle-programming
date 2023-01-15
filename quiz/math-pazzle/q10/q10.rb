#frozen_string_literal: true

# アメリカンスタイル、ヨーロピアンスタイルのルーレットの隣り合った n 個の数字の和について考える。
# アメリカンスタイル、ヨーロピアンスタイルそれぞれの n に対しての最大値を計算し、
# ヨーロピアンスタイルの和がアメリカンスタイルの和より小さくなる n を求めよ。
# ただし、2 ≦ n ≦ 36 とする。

module Q10

  EUROPIAN_ROULETTE = [0, 32, 15, 19, 4, 21, 2, 25, 17, 34, 6, 27, 13, 36, 11, 30, 8, 23, 10, 5, 24, 16, 33, 1, 20, 14, 31, 9, 22, 18, 29, 7, 28, 12, 35, 3, 26]
  AMERICAN_ROULETTE = [0, 28, 9, 26, 30, 11, 7, 20, 32, 17, 5, 22, 34, 15, 3, 24, 36, 13, 1, 00, 27, 10, 25, 29, 12, 8, 19, 31, 18, 6, 21, 33, 16, 4, 23, 35, 14, 2]

  def self.main
    eu_sums = (2..36).map {|n| calc_roulette_part_max_sum(EUROPIAN_ROULETTE, n) }
    us_sums = (2..36).map {|n| calc_roulette_part_max_sum(AMERICAN_ROULETTE, n) }
    answer = eu_sums.zip(us_sums).count {|eu, us| eu < us }
    puts answer
  end

  def self.calc_roulette_part_max_sum(roulette, n)
    0.upto(roulette.size - 1).map {|index| calc_roulette_part_sum(roulette, n, index) }.max
  end

  def self.calc_roulette_part_sum(roulette, n, start_index)
      size = roulette.size
      (0...n).sum {|i| roulette[(start_index + i) % size] }
  end
end

puts Q10.main
