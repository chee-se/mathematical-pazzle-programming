#frozen_string_literal: true

# 以下の土地面積と利用可能人数の表から、150人を超えないように土地面積を最大にせよ。

# 11000, 40人
# 8000, 30人
# 400, 24人
# 800, 20人
# 900, 14人
# 1800, 16人
# 1000, 15人
# 7000, 40人
# 100, 10人
# 300, 12人

module Q28
  # ナップザック問題
  # 全探索した。
  # 動的計画法でもできるらしい。

  GROUND_PEOPLE = [[11000, 40], [8000, 30], [400, 24], [800, 20], [900, 14], [1800, 16], [1000, 15], [7000, 40], [100, 10], [300, 12]]
  MAX_PEOPLE = 150

  @@ground_total = Array.new(MAX_PEOPLE + 1, 0)

  def self.main
    calculate
    puts find_best
  end

  def self.calculate
    GROUND_PEOPLE.each do |area, people|
      MAX_PEOPLE.downto(0) do |p|
        next if p != 0 && @@ground_total[p] == 0
        next if p + people > MAX_PEOPLE

        old_value = @@ground_total[p + people]
        new_value = @@ground_total[p] + area
        @@ground_total[p + people] = [old_value, new_value].max
      end
    end
  end

  def self.find_best
    @@ground_total.filter {|v| v > 0}.last
  end
end

Q28.main
