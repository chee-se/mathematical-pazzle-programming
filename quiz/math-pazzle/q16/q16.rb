#frozen_string_literal: true

# 3本の紐を使って2つの長方形と1つの正方形を作る。
# この時、長方形の面積の和が正方形の和となる組み合わせが何通りあるか求めよ。
# ただし、四角形の比が同じものは同一の組み合わせとして数えること。
# また、紐の長さ n は 1 ≦ n ≦ 500 の整数値とし、四角形の辺は整数値とする。

# ex1)
# 紐の長さが 20 の時
# 1．1 * 9 の長方形（10*2 = 20）-> 9
# 2．2 * 8 の長方形（10*2 = 20）-> 16
# 3．5 * 5 の正方形（10*2 = 20）-> 25


# ex2)
# 紐の長さが 40 の時
# 1．2 * 18 の長方形（20*2 = 40）-> 36
# 2．4 * 16 の長方形（10*2 = 40）-> 64
# 3．10 * 10 の正方形（20*2 = 40）-> 100

# 紐の長さが 60 の時
# 1．3 * 27 の長方形（30*2 = 60）-> 81
# 2．6 * 24 の長方形（30*2 = 60）-> 144
# 3．15 * 15 の正方形（30*2 = 60）-> 225

# ex2 は どちらも ex1 と同じ比のため、全てまとめて 1 通りのカウントになる。

# a^2 + b^2 == e^2
# (e + a) * (e - a) = b^2

module Q16

  MAX_LENGTH = 500
  MAX_SIDE = MAX_LENGTH / 2

  def self.main
    puts square_combination.size
  end

  def self.square_combination
    # 長さ500の紐で作れる最大の正方形は 125 * 125
    results = (1..MAX_LENGTH / 4).each_with_object([]) {|square_side, results|
      square_area = square_side**2
      side_limit = square_side * 2

      (1..side_limit / 2).each {|r1_short|
        (1..r1_short).each {|r2_short|
          r1_long = side_limit - r1_short
          r2_long = side_limit - r2_short
          rectangle_area = r1_short * r1_long + r2_short * r2_long

          results << [1, r2_short.to_f / r1_short, square_side.to_f / r1_short] if square_area == rectangle_area
        }
      }
    }
    results.uniq!
    p results
  end
end

Q16.main
