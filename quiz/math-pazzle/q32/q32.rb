#frozen_string_literal: true

# 畳を角が十字に交わらないように敷き詰めるとき、以下の部屋ではなんパターンの敷き方があるか。
# 1) 4 * 7 (14畳)
# 2) 5 * 6 (15畳)

module Q32

# 全探索で敷き詰められるパターンを抽出し、その中で十字に交わるかチェックする

  W = 'W'
  H = 'H'

  def self.main
    puts set_tatami(7, 4)
    puts set_tatami(6, 5)
  end

  def self.set_tatami(w, h)
    # 全探索で敷き詰める
    [W, H].repeated_permutation(w * h / 2).count do |pattern|
      map = tatami_map(w, h, pattern)
      map && check_valid_tatami?(w, h, map)
    end
  end

  def self.tatami_map(w, h, pattern)
    cursor = 0
    pattern.each_with_object(Array.new(h * w)).with_index(1) do |(direction, tatami_map), i|
      cursor += 1 until tatami_map[cursor].nil?
      return false unless set_next_tatami(tatami_map, w, h, cursor, direction, i)
    end
  end

  def self.set_next_tatami(map, w, h, cursor, direction, tatami)
    tatami_cursor = direction == W ? [cursor, cursor + 1] : [cursor, cursor + w]
    return false unless neighbor_block?(w, h, *tatami_cursor)

    tatami_cursor.all? {|c| map[c] = tatami if map[c].nil?}
  end

  def self.neighbor_block?(w, h, c1, c2)
    x1, y1 = c1 % w, c1 / w
    x2, y2 = c2 % w, c2 / w
    (x2 - x1).abs <= 1 && [y1, y2].all? {|y| (0...h).include?(y)}
  end

  def self.check_valid_tatami?(w, h, map)
    (0...w - 1).none? do |x|
      (0...h - 1).any? do |y|
        check_blocks = [x, y], [x + 1, y], [x, y + 1], [x + 1, y + 1]
        check_blocks.map {|x, y| map[y * w + x]}.uniq.size == 4
      end
    end
  end
end

Q32.main
