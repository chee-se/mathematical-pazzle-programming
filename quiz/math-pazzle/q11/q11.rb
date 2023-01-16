#frozen_string_literal: true

# 2桁以上のフィボナッチ数列のうち、自身の数字和で割り切れるものを小さいものから５個求めよ。
# ただし例に出したものは除くこと。

# cf) 数字和（digit sum）
# 数値を各桁で分割して合計したもの

# ex)
# 21 → 2 + 1 = 3 → 21 % 3 == 0
# 144 → 1 + 4 + 4 = 9 → 144 % 9 == 0

module Q11

  FIBONACCI_NUMBERS = []

  def self.main
    results = (1..).each_with_object([]) {|n, results|
      fibonacci = fibonacci(n)
      results.push(fibonacci) if fibonacci > 10 && dividable_by_digit_sum?(fibonacci)
      break results if results.size == 7
    }
    results.delete_if {|n| n == 21 || n == 144}
    puts results.to_s
  end

  def self.dividable_by_digit_sum?(num)
    num % num.digits.sum == 0
  end

  def self.fibonacci(n)
    return FIBONACCI_NUMBERS[n - 1] ||= 1 if [1, 2].include? n
    return FIBONACCI_NUMBERS[n - 1] ||= fibonacci(n - 2) + fibonacci(n - 1)
  end

end

Q11.main
