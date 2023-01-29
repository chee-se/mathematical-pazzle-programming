#frozen_string_literal: true

# 将棋盤上の二箇所に飛車と角を置く。すべての配置パターンで二つの駒の利きに入るマス目を合計し、その値を求めよ。

# ex) 26マス
# .#.......
# #d#######
# .#.#...#.
# .#..#.#..
# .#...h...
# .#..#.#..
# .#.#...#.
# .##.....#
# .#.......


module Q34

  def self.main
    puts (1..9).to_a.repeated_permutation(4).inject(0) {|result, positions|
      result + count_movable(*positions)
    }
  end

  def self.count_movable(x1, y1, x2, y2)
    return 0 if x1 == x2 && y1 == y2
    hisha, kaku = [x1, y1], [x2, y2]

    hisha_area = calc_hisha_area(*hisha, kaku)
    kaku_area = calc_kaku_area(*kaku, hisha)

    (hisha_area | kaku_area).size
  end

  def self.calc_hisha_area(x, y, kaku)
    unit_directions = [1, 0], [-1, 0], [0, 1], [0, -1]
    calc_area(x, y, kaku, unit_directions)
  end

  def self.calc_kaku_area(x, y, hisha)
    unit_directions = [1, 1], [1, -1], [-1, 1], [-1, -1]
    calc_area(x, y, hisha, unit_directions)
  end

  def self.calc_area(x, y, other, unit_directions)
    unit_directions.flat_map do |ux, uy|
      conflict = false
      (1..9).filter_map do |i|
        position = [x + ux * i, y + uy * i]
        # 別の駒か端にぶつかったら、そのラインは切る
        position unless conflict ||= (position == other || position.any? {|p| !(1..9).include?(p)})
      end
    end
  end
end

Q34.main
