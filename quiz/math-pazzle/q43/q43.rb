#frozen_string_literal: true

# 2n 枚のカードから、任意の位置から連続した n 枚を抜きだして、一番上に置くことを繰り返して。シャッフルする。
# n = 5 のとき、最短で何回のシャッフルで初期状態から逆順になるか答えよ。

# ex) n = 4 のとき
# 1234 -> 2314 -> 3124 -> 2431 -> 4321
# よって4回

module Q43

  # 全探索で答えを探す。

  N = 5
  MAX = 9999

  @memo = {}
  @reverse_memo = {}
  @queue = []

  class << self

    def main
      @queue = [[(1..N * 2).to_a, 0, false], [(1..N * 2).reverse_each.to_a, 0, true]]
      puts shuffle_reverse
    end

    def shuffle_reverse
      memo, cards, cnt, reverse = []
      loop do
        loop do
          cards, cnt, reverse = @queue.shift
          memo = reverse ? @reverse_memo : @memo
          break unless memo.has_key?(cards)
        end

        memo[cards] = cnt

        return @memo[cards] + @reverse_memo[cards] if @memo.has_key?(cards) && @reverse_memo.has_key?(cards)

        if reverse
          (1..N - 1).each { | i |
            # 先頭からN枚抜いて真ん中へ
            @queue << [cards[N...i + N + 1] + cards[0...N] + cards[i + N + 1...2 * N], cnt + 1, true]
          }
        else
          (1..N).each { | i |
            # 真ん中からN枚抜いて先頭へ
            @queue << [cards[i...i + N] + cards[0...i] + cards[i + N...2 * N], cnt + 1, false]
          }
        end
      end
    end
  end
end

Q43.main
