#frozen_string_literal: true

# 前後左右に1マス移動できるロボットを考える。
# 一度通ったマスを侵入不可能とした場合、12回の移動で実現できる移動パターンはいくつか求めよ。
# ex) 3 回の移動の場合は36 パターン
# 初手で下方向に移動できるパターンは、以下の 9 パターン。上下左右のパターンがあるので 9 * 4 で36パターン

#  0     0     0        0   0           0   0       3 0   0 3
#  1     1     1      2 1   1 2     3 2 1   1 2 3   2 1   1 2
#  2   3 2     2 3    3       3
#  3

module Q08

  UP = 'UP'
  DOWN = 'DOWN'
  LEFT = 'LEFT'
  RIGHT = 'RIGHT'

  DIRECTION = [UP, DOWN, LEFT, RIGHT]
  MOVE = {UP => [0, -1], DOWN => [0, 1], LEFT => [-1, 0], RIGHT => [1, 0]}

  def self.main
    puts count_walk_pattern(12)
  end

  def self.count_walk_pattern(step)
    start = [0, 0]
    step([start], step)
  end

  def self.step(footprint, step)
    return 1 if step == 0

    DIRECTION.sum {|direction|
      position = move_to(direction, footprint.last)
      next 0 if footprint.include?(position)
      step(footprint + [position], step - 1)
    }
  end

  def self.move_to(direction, position)
    position.zip(MOVE[direction]).map(&:sum)
  end
end

Q08.main
