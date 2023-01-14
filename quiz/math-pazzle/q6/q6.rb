#frozen_string_literal: true

# 10000 以下の偶数 n を初期値として以下の処理を繰り返したときに、元の初期値 n を得られる数がいくつあるか求めよ。
# 1) 奇数のとき、3 をかけて 1 を足す
# 2) 偶数のとき、2 で割る
# 3) ※ 一番最初の初期値のみ、3をかけて 1 を足す
# ex) 2 → 7 → 22 → 11 → 34 → 17 → 52 → 26 → 13 → 40 → 20 → 10 → 5 → 16 → 8 → 4 → 2
# ex) 6 → 3 → 10 → 5 → 16 → 8 → 4 → 2 → 1 → 4

# cf. ラコッツの予想（すべての自然数 n に対してこの処理をすると必ず1が得られる）

module Q6

  def self.main
    results = 2.step(10000, 2).filter {|n| self.process(n) }
    puts results.size
  end


  def self.process(n)
    m = n * 3 + 1

    loop do
      m = m.even? ? m / 2 : m * 3 + 1
      return true if m == n
      return false if m == 1 # 1 が出た場合、1 → 4 → 2 → 1 の無限ループ。2, 4 は 1 を得る前にループを終了する
    end
  end
end

Q6.main
