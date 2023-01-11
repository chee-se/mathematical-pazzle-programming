#frozen_string_literal: true

# 数値を各桁で分解して四則演算した結果が、元の数値の桁を逆から並べた数値になるものを
# 1000～9999の範囲から検出せよ

# 351 -> 3 * 51 -> 153
# 621 -> 6 * 21 -> 126
# 886 -> 8 * 86 -> 688

module Q2

  OPERATIONS  = ['+', '-', '*', '/', ' '].freeze

  def self.main
    puts (1000..9999).filter {|n| reversible?(n)}
  end

  def self.reversible?(n)
    n_str = n.to_s
    OPERATIONS.each {|o1|
      OPERATIONS.each {|o2|
        OPERATIONS.each {|o3|
          next if "#{o1}#{o2}#{o3}".eql?('   ')
          n_expr = n_str.dup.insert(1, o1).insert(3, o2).insert(5, o3).gsub(' ', '')
          # 不要な 0 を除去する
          # ruby の eval は 0 から始まる値を8進数として処理するため、そのままでは四則演算でエラーが発生する
          # ex) eval(15+08) => invalid octal digit error
          n_expr.gsub!(/(\D)0+(\d)/, '\1\2')
        begin
          r_result = eval(n_expr).to_s.reverse
          return true if r_result.eql? n_str
        rescue ZeroDivisionError => e
          next
        end
        }
      }
    }

    return false
  end
end

Q2.main
