#frozen_string_literal: true

# 一列に並んだ男女を二グループに分ける時、男女同数のグループを作れない並び順を求めよ。（男20人、女10人とする）
# ex) 男女3人ずつが「男男女男女女」に並んでいる場合、以下のどこで区切っても2グループとも男女比が同数にならない
# 男|男女男女女 -> 男女比 1:0、2:3
# 男男|女男女女 -> 2:0、1:3
# 男男女|男女女 -> 2:1、1:2
# 男男女男|女女 -> 3:1、0:2
# 男男女男女|女 -> 3:2、0:1

module Q09

  TOTAL_MAN = 20
  TOTAL_WOMAN = 10

  def self.main
    puts order_people_unbalanced(0, 0)
  end

  def self.order_people_unbalanced(man_count, woman_count)
    return 0 if man_count > TOTAL_MAN || woman_count > TOTAL_WOMAN # レギュレーションアウト
    return 0 if man_count > 0 && man_count == woman_count # 前方で同数グループ成立
    return 0 if man_count < TOTAL_MAN && TOTAL_MAN - man_count == TOTAL_WOMAN - woman_count # 後方で同数グループ成立
    return 1 if man_count == TOTAL_MAN && woman_count == TOTAL_WOMAN
    order_people_unbalanced(man_count + 1, woman_count) + order_people_unbalanced(man_count, woman_count + 1)
  end
end

puts Q09.main
