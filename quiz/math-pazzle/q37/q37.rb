#frozen_string_literal: true

# 6個のサイコロを並べる。先頭の出目が n のとき、先頭 n 個のサイコロを裏返して末尾に移動させる。
# これを繰り返すと、サイコロの数列はループするようになる。
# このとき、ループの中に現れず二度と再現されない列をすべて求めよ。

# ex)
# 132564 -> 325646 -> 646452 -> 131325 -> 313256 -> 256464 -> 646452(以降、3番目に戻ってループなので、1番目と2番目の数列は二度と現れない)
require 'set'

module Q37

  # すべての数列で全探索する
  @@answers = Set.new

  def self.main
    find_out_of_loop
    puts @@answers.size
  end

  def self.find_out_of_loop
    (111111..666666).each_with_object(Set.new) do |number, collector|
      next unless valid_dice?(number)
      next if collector.include?(number)

      counter = Hash.new(0)
      loop do
        counter[number] += 1
        break if counter[number] == 3
        number = process_number(number)
      end

      counter.each do |k, v|
        collector << k
        @@answers << k if v == 1
      end
    end
  end

  def self.process_number(number)
    shift = number / 100000
    split = 6 - shift

    left, right = number / 10 ** split, number % 10 ** split
    right * 10 ** shift + ((777777 - left) % 10 ** shift)
  end

  def self.valid_dice?(number)
    until number == 0
      return false if number % 10 >= 7 || number % 10 == 0
      number /= 10
    end
    true
  end
end

Q37.main
