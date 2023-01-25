#frozen_string_literal: true

# テーブルタップを使って一個のコンセントに n 個の家電をつなぐ。
# n = 20 の場合、テーブルタップのつなぎ方のパターンは何通りあるか。ただし、テーブルタップは2口のものと3口のものを使う。

# ex) 2口のタップに3口のタップをつなぐことを以下のように表現する
# 2 - 3
#
# n = 4 の場合、以下の4通り
#
# 2 - 2 - 2 => 1 + 1 + 2 = 4 (タップにタップをつなぐのに一口使うため)
#
# 2 - 3 = 1 + 3 = 4
#
# 2 - 2
#   - 2 => 0 + 2 + 2 = 4
#
# 3 - 2 => 2 + 2 = 4


module Q30
  # 2口のタップの数を a、3口のタップの数を b とすると、n = 1 + 2a + 3b - (a + b) = a + 2b + 1
  # よって、a = n - 2b - 1
  # まず a と b の組み合わせを網羅して、次に接続パターンを網羅する

  # a + b 個のタップの構造を考える。
  # メス端子はｎ個になるのに対して、オス端子は常に１個なので
  # a + b - 1個の連結済みタップに新しいタップを追加する場合、
  # 新しいタップに、a + b - 1個のタップを接続するように考えて
  # パターンを網羅する。

  N = 20
  @@memo = {}

  def self.main
    puts connect_table_tap(N)
  end

  def self.connect_table_tap(n)
    ab_combination = ab_combination(n)
    ab_combination.sum {|combination| connect_pattern(combination)}
  end

  def self.connect_pattern(ab)
    a, b = ab
    return 0 if a < 0 || b < 0
    return @@memo[ab] if @@memo.has_key?(ab)
    return @@memo[ab] = 1 if a + b <= 1 # [0, 0], [1, 0], [0, 1]
    # 2口先頭と3口先頭で場合分け
    @@memo[ab] = connect_to_new_tap(2, a - 1, b) + connect_to_new_tap(3, a, b - 1)
  end

  def self.connect_to_new_tap(new_hole, a, b)
    # a, b を new_hole 個のグループに分ける
    split_pattern = split_group(a, b, new_hole)

    # グループ分けしたタップをそれぞれの端子に刺したパターンを数える
    split_pattern.sum do |ab_group|
      # 重複パターンを除去
      # [a, b] = [6, 0] --split--> [3, 0] * [3, 0] となったとき
      # [3, 0] は2パターンだが [3, 0] * [3, 0] は重複パターンがあるので3パターンとなる。
      # 重複組合せで重複を除去する
      duplicate_checker = ab_group.each_with_object(Hash.new(0)) {|ab, dc| dc[ab] += 1}
      duplicate_checker.entries.inject(1) do |result, (ab, duplicate)|
        result * repeated_ncr(connect_pattern(ab), duplicate)
      end
    end
  end

  def self.split_group(a, b, group)
    # [a, b] を [[a - i, b - j], [i, j]] に分割する
    return [[[a, b]]] if group == 1
    (0..a).flat_map do |i|
      (0..b).flat_map do |j|
        new_group = [i, j]
        split_group(a - i, b - j, group - 1).map do |groups|
          (groups << new_group).sort
        end
      end
    end.uniq
  end

  def self.ab_combination(n)
    (0..((n - 1) / 2)).map {|b| [n - 2 * b - 1, b]}
  end

  def self.repeated_ncr(n, r)
    ((n)..(n + r - 1)).inject(:*) / (1..r).inject(:*)
  end
end

Q30.main
