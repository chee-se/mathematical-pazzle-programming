#frozen_string_literal: true

# 1とその数字以外の公約数を持つ二数を「友達」とする。
# 最大値をNとする7個の合成数（非素数）の組み合わせのうち、６段階たどらなければすべての数字を友達として結べない最小のNを求めよ

# ex) ４，６，９があったとき、４と９は友達でないが、６を介して友達の友達（２段階たどる友達）である。
# また、４，６，８，９は４から始まって、１段階で、６，８、２段階で９が友達になる。

module Q19
  # ６段階たどらなければならいとは、つまり最初と最後の数字の友達が一つ、残りの数字の友達が２つの状態である。
  # a - b - c - d - e - f - g
  # 最初と最後は素数の自乗、それ以外は互いに２つの素数の合成数であればよい。
  # a^2 - ab - bc - cd - de - ef - f^2
  # 最小の素数６つから上記の方法で合成数を算出し、最大値が最小のものを求める。

  @@prime_numbers = [2, 3]

  def self.main
    find_prime(6)
    puts find_n
  end

  def self.find_n
    @@prime_numbers.permutation(2).map {|edge_primes|
      (@@prime_numbers - edge_primes).permutation(4).map {|center_primes|
        seven_composite_numbers(*edge_primes, center_primes).max
      }.min
    }.min
  end

  def self.seven_composite_numbers(left, right, centers)
    ([left] + centers + [right]).each_cons(2).map{|a, b| a * b} + [left ** 2, right ** 2]
  end

  def self.find_prime(n)
    while @@prime_numbers.size < n
      @@prime_numbers << @@prime_numbers[-1].step(by: 2).find {|i|
        @@prime_numbers.none? {|p| i % p == 0 }
      }
    end
    @@prime_numbers
  end
end

Q19.main
