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
  @queue = []

  class << self

    def main
      @queue = [[(1..N * 2).to_a, 0]]
      puts shuffle_reverse
    end

    def shuffle_reverse
      cards, cnt = nil, nil
      loop do
        loop do
          cards, cnt = @queue.shift
          break if !@memo.has_key?(cards)
        end

        @memo[cards] = cnt

        reverse_cards = cards.reverse
        return @memo[cards] + @memo[reverse_cards] if @memo.has_key?(reverse_cards)

        (1..(cards.size - N)).each { | i |
          @queue << [cards[i...i + N] + cards[0...i] + cards[i + N...2 * N], cnt + 1]
        }
      end
    end
  end
end

Q43.main
