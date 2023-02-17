#frozen_string_literal: true

# 32ビットのIPアドレスについて考える。
# ２進数表記で左右対称になり１０進数表記で０～９の数字が１度ずつ現れるIPアドレスはいくつあるか

module Q41
  # 8ビットの数値二つを逆転させてIPパートを作り、条件に合うかを見る
  class << self

    def main
      puts (0..255).to_a.repeated_permutation(2).count { |left, right|
        beautiful_ip?(left, right)
      }
    end

    def beautiful_ip?(part1, part2)
      part3 = reverse_bi(part2)
      part4 = reverse_bi(part1)

      digits = [part1, part2, part3, part4].flat_map {|ip_part|
        split_digit(ip_part)
      }

      if digits.size == 10 && digits.uniq.size == 10
        puts [part1, part2, part3, part4].to_s
        true
      end
    end

    def reverse_bi(number)
      reversed = 8.times.inject(0) { |ret, _|
        ret += number & 1
        number >>= 1
        ret <<= 1
      }
      reversed >> 1
    end

    def split_digit(number)
      (0..).each_with_object([]) { |_, digits|
        digits << number % 10
        number /= 10
        break digits if number == 0
      }
    end
  end
end

Q41.main
