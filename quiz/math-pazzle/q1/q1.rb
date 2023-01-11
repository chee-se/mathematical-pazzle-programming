#frozen_string_literal: true

# 10進数、2進数、8進数のいずれで表現しても回文になる数値のうち、10以上の最小値を求めよ。

answer = (10...).each {|n|
  break n if [2, 8, 10].all? {|radix| n.to_s(radix) == n.to_s(radix).reverse }
}
puts [2, 8, 10].map {|radix| answer.to_s(radix) }.to_s
