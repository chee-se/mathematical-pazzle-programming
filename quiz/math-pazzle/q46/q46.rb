#frozen_string_literal: true

# 1～７の数字を並べたランダムな数列を小さい順を戦闘にソートする。
# 2つの数字を入れ替えることでソートしていくときの交換回数について考える。
# すべての数列を並び替えたときの交換回数の合計を求めよ

module Q46

  class << self
    def main
      @memo = {}
      puts (1..7).to_a.permutation.sum { |sequence| swap_sort_count(sequence, 7) }
    end

    def swap_sort_count(sequence, n)
      return 0 if n == 1
      return @memo[[sequence[0...n], n]] if @memo.has_key?([sequence[0...n], n])
      @memo[[sequence[0...n], n]] = swap(sequence, n, sequence.index(n) + 1) + swap_sort_count(sequence, n - 1)
    end

    def swap(sequence, num, pos)
      return 0 if pos == num
      sequence[num - 1], sequence[pos - 1] = sequence[pos - 1], sequence[num - 1]
      return 1
    end
  end
end

Q46.main
