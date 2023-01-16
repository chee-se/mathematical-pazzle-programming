#frozen_string_literal: true

# 平方根を小数で表したときに、０～９までの数字が最も早くすべて現れる最小の整数を、整数部分を含む場合と含まない場合でそれぞれ求めよ。

# cf) 数字和（digit sum）
# 数値を各桁で分割して合計したもの

# ex)
# 2 → 1.4142135623709548 → 19桁

module Q12

  REJECT = 10**100
  TENTATIVE_UPPER_LIMIT = 1000000

  def self.main
    result = (1..TENTATIVE_UPPER_LIMIT).each_with_object({only_decimal: [nil, REJECT], all_digit: [nil, REJECT]}) {|i, result|
      sqrt_value_str = high_precision_sqrt_str(i)

      if result[:only_decimal][1] > 10
        only_decimal_answer = [i, digit_getting_all_number(decimal_part(sqrt_value_str))]
        result[:only_decimal] = min_result(only_decimal_answer, result[:only_decimal])
      end

      if result[:all_digit][1] > 10
        all_digit_answer = [i, digit_getting_all_number(sqrt_value_str.delete('.'))]
        result[:all_digit] = min_result(all_digit_answer, result[:all_digit])
      end

      break result if result[:only_decimal][1] == 10 && result[:all_digit][1] == 10
    }
    puts "only decimal part answer: #{result[:only_decimal][0]}"
    puts "include integer part answer: #{result[:all_digit][0]}"
  end

  def self.digit_getting_all_number(n_str)
    indexes = (0..9).map{|i| n_str.index(i.to_s)}.compact
    indexes.size == 10 ? indexes.max + 1 : REJECT
  end

  def self.high_precision_sqrt_str(n)
    # 単精度で６～７桁、倍精度で１５桁程度の精度なのでこれで十分
    '%10.100f'%Math.sqrt(n) # -> sprintf('%10.100f', Math.sqrt(n))
  end

  def self.decimal_part(n_str)
    n_str.sub(/.+\.(\d)/) { $1 }
  end

  def self.min_result(result1, result2)
    v1, v1_digit = result1
    v2, v2_digit = result2

    return result1 if v2_digit == REJECT

    if v1_digit != v2_digit
      v1_digit < v2_digit ? result1 : result2
    else
      v1 <= v2 ? result1 : result2
    end
  end
end

Q12.main
