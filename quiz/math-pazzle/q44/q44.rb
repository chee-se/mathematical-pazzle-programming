#frozen_string_literal: true

# 大中小の３つのグラスA, B, Cがあり、その容量は A > B > C かつ、A = B + C かつ、B と C は互いに素とする。
# グラス A に満たされた水をグラス B と C のみを使って、グラス A の半量だけグラス A に残したい。
# A の大きさが 10 以上 100 以下のとき、半量だけ残せる B, C の組み合わせ数を求めよ。

module Q44

  # それぞれの容量を A = a、B = b、C = c とすると、c = a - b
  # さらに、半量を量れるので、a は偶数、b > a / 2 である。
  # A = 2n とすると、2 * n > b > nであり、c = 2 * n - b

  # A, B, C のグラスは必ず、どれか一つが空か、どれか一つが満タンになっている
  # A が半量になる時、B は空も満タンもありえない。
  # よって最後の配置は以下の2パターン
  # [n, b-n, 2n-b] <- [3n-b, b-n, 0]
  # [n, n, 0] <- [b-n, n, 2n-b] <- [b-n, 3n-b, 0] <- [0, 3n-b, b-n]
  # よって、b-n, 3n-bを作れるかどうかが判定基準になる。

  # でも全探索と大差なさそうなので全探索する

  class << self

    def main
      results = (10..100).filter{|a| a % 2 == 0}.flat_map {|a|
        (a / 2 + 1...a).filter_map {|b|
          c = a - b
          [a, b, c] if b.gcd(c) == 1 && challenge(a, b, c)
        }
      }
      puts results.size
    end

    def challenge(ma, mb, mc)
      memo = {}
      queue = [[ma, 0, 0]]
      capacity = [ma, mb, mc]

      loop do
        return if queue.empty?

        state = queue.shift
        next if memo.has_key?(state)
        return true if state[0] == ma / 2

        queue += next_state(state, capacity)
        memo[state] = true
      end
    end

    def next_state(state, capacity)
      [0, 1, 2].permutation(2).filter_map {|from, to|
        next if state[from] == 0 || state[to] == capacity[to]
        move = [capacity[to] - state[to], state[from]].min
        state.dup.tap {|result|
          result[from] -= move
          result[to] += move
        }
      }
    end
  end
end

Q44.main
