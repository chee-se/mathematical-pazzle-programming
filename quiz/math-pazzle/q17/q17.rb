#frozen_string_literal: true

# 30人の男女を整列させる時、女が隣り合わない並び方は何通りあるか求めよ。

module Q17

  # 2^30 から女子が隣り合うパターンを考慮すると
  # 全探索は、O(2^N)となり、結果が返ってこないので効率化する手段を考案する。

  # N についての漸化式 an で考える。
  # 末尾が男の時のパターン数を bn、末尾が女の時のパターン数を cn とすると、an = bn + cn となる。
  # また、b(n+1) = bn + cn、c(n+1) = bn である。
  # よって、a(n+1) =  b(n+1) + c(n+1) =  2 * bn + cn となる。
  # 計算量はO(N)となる

  # N = 1 の時、b1 = 1、c1 = 1、a1 = 2
  # N = 2 の時、b2 = 2、c2 = 1、a2 = 3
  # N = 3 の時、b3 = 3、c3 = 2、a3 = 5
  # N = 4 の時、b4 = 5、c4 = 3、a4 = 8

  N = 30

  @@b = [1]
  @@c = [1]

  def self.main
    puts a(30)
  end

  def self.a(n)
    b(n) + c(n)
  end

  def self.b(n)
    @@b[n - 1] ||= b(n - 1) + c(n - 1)
  end

  def self.c(n)
    @@c[n - 1] ||= b(n - 1)
  end
end

Q17.main
