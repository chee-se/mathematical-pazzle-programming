#frozen_string_literal: true

# 地上（0段）と二階（10段）にそれぞれいる二人が、1回の移動でそれぞれ1~4段進む時
# 同じ段に降りるパターンが何通りあるか求めよ。

module Q15

  def self.main
    puts step_pattern(20)
  end

  def self.step_pattern(n)
    @@pattern ||= []
    return @@pattern[n] unless @@pattern[n].nil?
    return @@pattern[n] ||= 1 if n == 0
    return @@pattern[n] ||= step_at_once_pattern(n) if n <= 2

    max_step_at_once = [n, 8].min
    @@pattern[n] = (2..max_step_at_once).sum {|i| step_pattern(n - i) * step_at_once_pattern(i)}
  end

  def self.step_at_once_pattern(n)
    @@pattern_once ||= []
    @@pattern_once[n] unless @@pattern_once[n].nil?
    @@pattern_once[n] = [1, 2, 3, 4].repeated_permutation(2).count {|steps| steps.sum == n}
  end
end

Q15.main
