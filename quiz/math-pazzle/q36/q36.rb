#frozen_string_literal: true

# 任意の正の整数 n について、0 と 7 のみで構成される n の正の倍数が存在する。
# 0 と 7 の数字のみでっ構成される n の性の倍数の中で最小の数を求め、それが回文数になっているものを
# 1 <= n <= 50 の範囲からすべて求めよ。

# ex)
# n = 2 -> 2 * 35 = 70
# n = 3 -> 3 * 2359 = 7077
# n = 4 -> 4 * 175 = 700
# n = 5 -> 5 * 14 = 70
# n = 6 -> 6 * 1295 = 7770
# n = 7 -> 7 * 539 = 7007

module Q36

  N_RANGE = 1..50

  # 7 と 0 で構成される数字を小さいものから順に作り、それを１～５０で試し割りしていく。
  @@answers = Array.new(N_RANGE.last, false)

  def self.main
    puts find_palindromic(N_RANGE).to_s
  end

  def self.find_palindromic(n_range)
    (1..).each do |i|
      # 2進数に変換し、10進数に解釈し直して 7 倍することで、0 と 7 だけで構成された数値を作る
      zero_seven_number = i.to_s(2).to_i * 7
      N_RANGE.each do |n|
        @@answers[n - 1] = zero_seven_number if !@@answers[n - 1] && zero_seven_number % n == 0
      end
      break if @@answers.all?
    end
    @@answers.filter_map.with_index(1) {|ans, n| [n, ans] if ans.to_s == ans.to_s.reverse}
  end
end

Q36.main
