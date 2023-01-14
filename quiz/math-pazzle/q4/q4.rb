#frozen_string_literal: true

# n cm の棒を m 人で 1cm の長さの端材になるまで切り分ける。
# 一本の棒は一度に一人しか切ることができない。
# 以下の条件の場合、最小何回で切り分けが完了するか求めよ。
# 1) n = 20, m = 3
# 2) n = 100, m = 5

# ex) n = 8, m = 3 の場合
# 0: --------                     => n = 8 の棒
# 1: ----/----
# 2: --/--  --/--
# 3: -/-  -/-  -/-  --            => m = 3 のため、最大で3つの棒しか切れない
# 4: -  -   -  -  -  -  -  -/-
# Answer: 4

module Q4

  def self.main
    puts cut_pole([20], 3)
    puts cut_pole([100], 5)
  end


  def self.cut_pole(poles, member)
    return 0 if poles.all? {|piece| piece == 1}

    0.upto(Float::INFINITY) {|i|
      return i if poles.empty?

      cut_poles = [poles.shift(member)].flatten!
      pieces = cut_poles.map{|piece| cut_one(piece)}.flatten!.filter {|piece| piece > 1}
      poles.concat(pieces).sort!.reverse!
    }
  end

  def self.cut_one(pole)
    piece = pole / 2
    [pole - piece, piece]
  end
end

Q4.main
