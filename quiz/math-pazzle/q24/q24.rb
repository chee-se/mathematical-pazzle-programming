#frozen_string_literal: true

# ストラックアウトで９枚の的を撃ち抜くとき、的を抜く順番は何通りあるか。
# 二枚抜きあり、ただし５番だけ二枚抜きできないものとする。
# また投げた球は必ず的に命中する。

# 1   2   3
#    ___
# 4 | 5 | 6
#   ¯¯¯¯
# 7   8   9

module Q24

  # 二枚抜きなしなら９項の順列で良い
  # 二枚抜きは隣り合った二枚を合成して新しい一枚を作る処理とする
  # 二枚抜きの出現回数０～４と、二枚抜きの組み合わせを考えてパターン数を追加する

  # 循環のため（1-2パターンと4-1パターンを網羅するため）先頭と末尾に1を持っておく
  ROUND_TARGET = [1, 2, 3, 6, 9, 8, 7, 4, 1]

  def self.main
    puts strike_out
  end

  def self.strike_out
    (0..4).sum do |double_strike_times|
      double_pattern = double_strike_pattern(double_strike_times, ROUND_TARGET)
      permutation(9 - double_strike_times) * double_pattern
    end
  end

  def self.double_strike_pattern(times, round_target)
    return 1 if times == 0 # 初回に times = 0 で呼び出された場合

    size = round_target&.size || 0
    return 0 if size <= 1
    return size - 1 if times == 1

    # 重複なしで二枚抜きのパターンをカウントする
    # １回目：round_target の i と i + 1 を撃ち抜く -> (i + 2)..(i + 7)を抽出（0 <= i <= 7）
    # ２回目：round_target の j と j + 1 を撃ち抜く -> (j + 1).. を抽出（j > i + 1）
    (0..7).sum do |i|
      double_strike_pattern(times - 1, round_target[(i + 2)..(i + 7)])
    end
  end

  def self.permutation(n)
    return 1 if n == 0
    (1..n).inject(:*)
  end
end

Q24.main
