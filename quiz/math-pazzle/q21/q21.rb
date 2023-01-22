#frozen_string_literal: true

# パスカルの三角形の2014番目の0が何段目に登場するか求めよ

        # 1                  1
        # 2                 1 1
        # 3                1 0 1
        # 4               1 1 1 1
        # 5              1 0 0 0 1
        # 6             1 1 0 0 1 1
        # 7            1 0 1 0 1 0 1
        # 8           1 1 1 1 1 1 1 1
        # 9          1 0 0 0 0 0 0 0 1
        # 10        1 1 0 0 0 0 0 0 1 1
        # 11       1 0 1 0 0 0 0 0 1 0 1        7
        # 12      1 1 1 1 0 0 0 0 1 1 1 1       4
        # 13     1 0 0 0 1 0 0 0 1 0 0 0 1      9
        # 14    1 1 0 0 1 1 0 0 1 1 0 0 1 1     6
        # 15   1 0 1 0 1 0 1 0 1 0 1 0 1 0 1    7
        # 16  1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1   0


module Q21

  # 3 段目に 1
  # 5~7 段目に 6 + 1 + 1 = 8
  # 9~15 段目に 28 + 8 + 8 = 44
  # 17~31 段目に 120 + 44 + 44 = 208
  # 33~63 段目に 496 + 208 + 208 = 912

  # 中心に n 個目の三角形が完成する段の漸化式は a(n+1) = an * 2 + 1
  # 中心に n 個目の三角形が完成したときの、0の出現数 b(n+1) = an * (an + 1) / 2 + 3 * bn
  ZERO_NUM = 2014

  A = []
  B = []

  def self.main
    # n + 1 個目の中心の三角が完成したら ZERO_NUM を超える
    n = pascal_triangle(ZERO_NUM) - 1
    remaining_zero = ZERO_NUM - b(n)

    line_no = a(n) + 2
    line_no =  read_next_lines(line_no, remaining_zero)
    puts line_no
  end

  def self.pascal_triangle(zero_num)
    (1..).find {|i| b(i) > zero_num}
  end

  def self.read_next_lines(from, remaining, line = nil)
    line ||= [true] + Array.new(from - 2, false) + [true]
    remaining -= line.count(false)

    return from if remaining <= 0

    read_next_lines(from + 1, remaining, next_line(line))
  end

  def self.next_line(line)
    new_line = line.each_cons(2).map {|(left, right)| left ^ right}
    [true] + new_line + [true]
  end

  def self.a(n)
    return A[n - 1] ||= 3 if n == 1
    A[n - 1] ||= a(n - 1) * 2 + 1
  end

  def self.b(n)
    return B[n - 1] ||= 1 if n == 1
    B[n - 1] ||= a(n - 1) * (a(n - 1) + 1) / 2 + b(n - 1) * 3
  end
end

Q21.main
