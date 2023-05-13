#frozen_string_literal: true

# n進数の数をグレイコードで表現し、それをさらにn進数の数としてグレイコード化することを繰り返す。
# 1) n = 16、初期値は「808080」のとき、何回目で元の数値に戻るか答えよ。
# 2) n = 16、初期値は「abcdef」のとき、何回目で元の数値に戻るか答えよ。

module Q48

  # 愚直に計算する
  # グレイコード化：1ビット右シフトしたフィルタとの排他的論理和
  # 排他的論理和：各桁の差を base で割ったあまり

  class << self
    N = 16

    def main
      [0x808080, 0xabcdef].each do |num|
        puts "#{num}: #{process(num, N)}"
      end
    end

    def process(n, base)
      digit = (1..).each {|i| break i if base ** i > n}

      x = n
      (1..).each do |i|
        x = to_gray_code(x, base, digit)
        return i if x == n
      end
    end

    def to_gray_code(n, base, digit)
      gray_code_filter = n / base
      xor(n, gray_code_filter, base, digit)
    end

    def xor(a, b, base, digit)

      result = digit.times.map do
        a, a_bottom = a.divmod(base)
        b, b_bottom = b.divmod(base)
        (a_bottom - b_bottom) % base
      end
      result.each_with_index.reduce do |(a, _i_a), (b, i_b)|
        a += b * base ** i_b
      end
    end
  end
end

Q48.main
