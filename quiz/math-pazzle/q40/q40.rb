#frozen_string_literal: true

# 1～nまでのカードn枚を並べる。
# 先頭のカードの数がmのとき、先頭からm枚を逆順に並べ直す。
# カードが変化しなくまでこの処理を繰り返したとき、最大何回の入れ替えでカードは変化しなくなるか
# ただし、n=9とする

# ex) n=6の場合
# 362154 -> 263154 となる

module Q40
  # 深さ優先探索で探す
  # 先頭が１のパターンからスタートし、i枚目がiのとき入れ替え可能と見る

  N = 9

  class << self

    def main
      result = (2..N).to_a.permutation(N - 1).map { |numbers|
        process([1] + numbers, 0)
      }.max_by {|_, cnt| cnt}

      puts result.to_s
    end

    def process(numbers, count)
      result = (2..N).filter_map { |i|
        process(reverse(numbers, i), count + 1) if numbers[i - 1] == i
      }
      return [numbers, count] if result.empty?

      result.max_by {|_, cnt| cnt}
    end

    def reverse(numbers, i)
      numbers[0..(i - 1)].reverse + numbers[i..]
    end
  end
end

Q40.main
