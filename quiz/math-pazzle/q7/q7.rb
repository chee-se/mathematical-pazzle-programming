#frozen_string_literal: true

# 日付を8桁の数値YYYYMMDDに変換し、更に2進数に変換後、逆から並べ、10進数に戻したとき、元のYYYYMMDDに戻る日付を求めよ。
# 範囲は、1964年10月10日～2020年7月24日とする

require 'date'

module Q7

  def self.main
    start = Date.new(1964, 10, 10)
    last = Date.new(2020, 7, 24)
    results = (start..last).filter {|date| check_date(date)}
    puts results
  end


  def self.check_date(date)
    original = date.strftime('%Y%m%d').to_i
    original == original.to_s(2).reverse.to_i(2)
  end
end

Q7.main
