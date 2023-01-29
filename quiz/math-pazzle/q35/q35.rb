#frozen_string_literal: true

# 長さ n メートル正方形 ABCD に、1 メートルおきに碁盤の目状に道が引かれている。
# この頂点 A, C から二人が同時に同速で反対の頂点へ最短距離で移動するとき、以下のどちらか、あるいは両方の条件を満たすパターンは何パターンあるか。
# ただし、n = 6 とする。
# 1. 二人が同一直線上に二度止まること
# 2. 二人が同じ座標に重なること

module Q35

  # 二人の移動を全探索で調べる。
  N = 6

  A = [0, 0]
  A_MOVE = [[0, 1], [1, 0]]

  B = [6, 6]
  B_MOVE = [[0, -1], [-1, 0]]

  def self.main
    puts walk_simulation(A, B)
  end

  def self.walk_simulation(pos1, pos2, same_line = 0)
    return 0 unless [pos1, pos2].all? {|pos| valid_position?(pos)}
    if pos1 == [N, N] && pos2 == [0, 0]
      return same_line >= 2 ? 1 : 0
    end

    x1, y1 = pos1
    x2, y2 = pos2
    same_line += 1 if x1 == x2 || y1 == y2
    same_line += 2 if pos1 == pos2

    A_MOVE.sum {|dx1, dy1|
      B_MOVE.sum {|dx2, dy2|
        next_pos1 = [x1 + dx1, y1 + dy1]
        next_pos2 = [x2 + dx2, y2 + dy2]
        walk_simulation(next_pos1, next_pos2, same_line)
      }
    }
  end

  def self.valid_position?(position)
    position.all? {|p| (0..N).cover?(p)}
  end
end

Q35.main
