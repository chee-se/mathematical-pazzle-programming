#frozen_string_literal: true

require "csv"


# 百人一首ですべての句を一意に識別する時、最低何文字読み取る必要があるか。

# ex) 以下の句は上の句から1文字、下の句から1文字で計二文字で識別できる
# むらさめのつゆもまたひぬまきのはに,きりたちのほるあきのゆふくれ

module Q33

  # CSV から単価を読み込む。
  # 上の句、下の句ごとに一意になる文字数を検出して合計する

  CSV_FILENAME = 'q33.csv'

  def self.main
    tanka = read_tanka
    puts tanka.transpose.sum {|phrase| count_unique_char(phrase)}
  end

  def self.count_unique_char(phrases)
    (0..).inject(0) do |result, i|
      break result if phrases.empty?

      # 先頭 i+1 文字で一意になったものを除外し、残った句を次のループにかける
      grouped = phrases.group_by {|phrase| phrase[0..i]}
      ununique_phrases = grouped.delete_if {|k, v| v.size == 1}.values.flatten
      unique = phrases.size - ununique_phrases.size

      phrases = ununique_phrases
      result + (i + 1) * unique
    end
  end

  def self.read_tanka
    CSV.foreach(CSV_FILENAME, headers: true).map do |row|
      row[3..4]
    end
  end
end

Q33.main
