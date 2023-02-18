#frozen_string_literal: true

# 一つの数字だけを使って、四則演算で任意の数を作る。このとき、括弧をつくかって計算順を変えてはいけない。
# 1234 という数をできるだけ少ない個数で作る時、どの数でどのような式になるかすべて答えよ。

# ex)
# 1000 = 1111 - 111 -> 1 を 7 個だけ使用
# 1000 = 999 + 9 / 9 -> 9 を 5 個だけ使用
# 1000 = 888 + 88 + 8 + 8 + 8 個だけ使用

module Q42

  # 1234 = 1111 + 111 + 11 + 1 なので、最大 10 個の数字で作れるかどうかだけを見る


  OPERATORS = ['+', '-', '*', '.0/', '']

  class << self

    def main
      @min_count = 10
      results = (1..9).map { |i| find_expr(i) }.flatten.compact
      results = results.group_by { |expr| expr.count('1-9') }
      results = results[results.keys.min].uniq.map{ |expr| expr.gsub(/\.0/, '')}
      puts [results.size, results].to_s
    end

    def find_expr(n)
      (4..@min_count).filter_map {|i|
        results = create_expr(n, i, OPERATORS).filter { |expr| eval(expr) == 1234 }
        next nil if results.empty?
        @min_count = i
        break results
      }
    end

    def create_expr(n, cnt, operators)
      numbers = Array.new(cnt, n)
      operators.repeated_permutation(numbers.size - 1).map { |optr_pattern|
        numbers.zip(optr_pattern).flatten.join
      }
    end
  end
end

Q42.main
