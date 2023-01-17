#frozen_string_literal: true

# 以下の覆面算を満たす組み合わせが何通りあるか求めよ。ただし、最上位は0ではなく、同じ数字が入る文字はないものとする。
# READ + WRITE + TALK = SKILL

# ex) We * Love = CodelQ の場合
# → W = 7, e = 4, L = 3, o = 8, v = 0, C = 2, d = 1, l = 9, Q = 5
# 74 * 3804 = 281496


module Q13
# 手がかりをまとめる
# 0. 文字は10種（READWITLKS）。0～9全て使う。
# 0. すべての桁は X+Y+Z（+繰り上がり）で表現される。X+Y+Zの範囲は、6~24。繰り上がりは、0~2。
# 1. 一の位 D+E+K % 10 = L
# 2. 十の位 A+T+L+（繰り上がり） % 10 = L
# 3. 百の位 E+I+A+（繰り上がり） % 10 = I
# 4. 千の位 R+R+T+（繰り上がり） = K
# 5. 万の位 W +（繰り上がり） = S
# 6. 最上位は0でないので、R, W, T, S ≠ 0

  NUMBERS = (0..9).to_a

  def self.main
    puts NUMBERS.permutation.count {|combination| check_mask_sum(*combination) }
  end

  def self.check_mask_sum(r, e, a, d, w, i, t, l, k, s)
    return unless [r, w, t, s].all? {|num| num > 0}
    up1, places1 = number_to_up_and_places(d + e + k)
    up2, places2 = number_to_up_and_places(a + t + l + up1)
    up3, places3 = number_to_up_and_places(e + i + a + up2)
    up4, places4 = number_to_up_and_places(r + r + t + up3)
    up5, places5 = number_to_up_and_places(w + up4)

    if up5 == 0 && places5 == s && places4 == k && places3 == i && places2 == l && places1 == l
      puts [r, e, a, d, w, i, t, l, k, s].to_s
      result(r, e, a, d, w, i, t, l, k, s)
      return true
    end
  end

  def self.number_to_up_and_places(n)
    [n / 10, n % 10]
  end

  def self.word_to_num(*numbers)
    numbers.join.to_i
  end
end

Q13.main
