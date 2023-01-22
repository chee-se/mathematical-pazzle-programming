#frozen_string_literal: true

# 受難のファサードの数列から任意の数を取り出して和を計算するとき、最も出現回数の多い和を求めよ。

module Q20

  # 全探索は O(２^n) である。
  # 高速化の手段を考える
  # 尺取り虫足し算 -> 複数項の計算コストは減るが、組合せ爆発に対処できない
  # (x - 1)個の項の合計をメモしてn個の合計を計算する -> 残った項もキャッシュしないといけないので微妙そう

  # とりあえずやってみる。
  # １個の組み合わせを数えつつ、２個の組み合わせに使う
  # 2個の組み合わせを数えつつ、３個の組み合わせに使う

  NUM = [
    1, 14, 14, 4,
    11, 7, 6, 9,
    8, 10, 10, 5,
    13, 2, 4, 15
  ]

  N = NUM.size

  MAX = NUM.sum

  COUNTER = Array.new(MAX + 1, 0)

  def self.main
    count_comb_sum
    puts COUNTER.index(COUNTER.max)
    puts COUNTER.to_s
  end

  def self.count_comb_sum(n = 0, sum = 0)
    (n...N).each {|i|
      COUNTER[sum + NUM[i]] += 1
      count_comb_sum(i + 1, sum + NUM[i])
    }
  end
end

Q20.main
