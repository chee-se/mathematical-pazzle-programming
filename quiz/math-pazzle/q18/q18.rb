#frozen_string_literal: true

# 各項が、1～N の値を持つ、重複のない長さNの数列を考える。
# 隣り合う2数の和が必ず平方数となる最小のNを求めよ。ただし、先頭と末尾は隣り合っているものとして扱うこと。

module Q18

  @@squares = [1]

  def self.main
    puts (2..).find {|n| square_line?(n)}
  end

  def self.square_line?(n)
    prepare_squares(n)
    recursive_square_line?((1...n).to_a, n, n)
  end

  def self.recursive_square_line?(line, i, start)
    # 最後に末尾と先頭の組み合わせを判定する
    return @@squares.include?(i + start) if line.empty?

    @@squares.any? {|s|
      recursive_square_line?(line - [s - i], s - i, start) if line.include?(s - i)
    }
  end

  def self.prepare_squares(n)
    m = Math.sqrt(@@squares[-1]).to_i
    while @@squares[-1] < 2 * n
      @@squares << (m += 1) ** 2
    end
  end

  def self.show
    @@squares
  end
end

Q18.main
