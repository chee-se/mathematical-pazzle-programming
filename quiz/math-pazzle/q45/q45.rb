#frozen_string_literal: true

# n行、n列のテーブルに数値を配置してn桁の素数を2n個配置されたマトリクスを作りたい。n=3のとき、何パターンのテーブルがあるか求めよ。
# ただし、同じ素数をニ度使ってはいけない

# ex) n=2のとき
# 1 3
# 1 7
# -> 11, 13, 17, 37 の素数を使用したマトリクス

# 2 3
# 9 7
# -> 23, 29, 37, 97 の素数を使用したマトリクス

# 1 7
# 7 3
# 17, 17, 73, 73 の素数を使用しているが、同じ素数を複数回使っているので不適当

require 'prime'

module Q45

  # 1. 3桁の素数をすべて列挙する。
  # 2. 三列目、三行目の素数を仮選出する。
  # 3. ニ列目、二行目の素数を仮選出する。
  # 4. 一列目、一行目の素数を仮選出する。
  # 5. ２～４の工程で枝を切りながら全探索する

  class << self

    def main
      primes = (100..999).filter(&:prime?)
      one_primes = primes.group_by{|p| p % 10}
      matrix = [
        [nil, nil,nil],
        [nil, nil,nil],
        [nil, nil,nil]
      ]

      puts count_matrix(matrix, [], [primes, one_primes], 3)
    end

    # step: 3 -> 3行目、3列目の素数決定、2 -> 2行目、2列目の素数決定、1 -> 1行目、1列目の素数決定
    def count_matrix(m, used_primes, all_primes, step)
      primes, one_primes = all_primes

      if step == 1
        d1, d2 = [m[0][1] * 10 + m[0][2], m[1][0] * 10 + m[2][0]]
        return 0 if d1 == d2
        return (1..9).count {|n|
          p1 = n * 100 + d1
          p2 = n * 100 + d2
          [p1, p2].all? {|p| p.prime? && !used_primes.include?(p)}
        }
      end

      if step == 2
        nn = [m[2][1], m[1][2]]
        group1, group2 = nn.map{|n| one_primes[n]}
        return 0 if group1.nil? || group2.nil?
        pairs = group1.product(group2).reject {|p1, p2|
          p1 == p2 || used_primes.include?(p1) || used_primes.include?(p2) || (p1 / 10) % 10 != (p2 / 10) % 10
        }

        return pairs.sum {|p1, p2|
          m[0][1] = p1 / 100
          m[1][1] = (p1 / 10) % 10
          m[1][0] = p2 / 100

          count_matrix(m, used_primes + [p1, p2], all_primes, 1)
        }
      end

      if step == 3
        return (0..9).sum {|n|
          group = one_primes[n]
          next 0 if group.nil?

          group.permutation(2).sum {|p1, p2|
            m[0][2] = p1 / 100
            m[1][2] = (p1 / 10) % 10
            m[2][2] = p1 % 10

            m[2][0] = p2 / 100
            m[2][1] = (p2 / 10) % 10

            count_matrix(m, [p1, p2], all_primes, 2)
          }
        }
      end
    end
  end
end

Q45.main
