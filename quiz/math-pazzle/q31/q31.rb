#frozen_string_literal: true

# n = 6 の正方形に1cmごとに格子状に道が引かれている。
# 左上隅から右下隅を通って左上隅に戻る最短経路は何通りあるか
# ただし、一度使った道を通ってはいけない。（交差点を通るのはOK）
# n = 6
# ┏━┳━┳━┳━┳━┳━┓
# ┣━╋━╋━╋━╋━╋━┫
# ┣━╋━╋━╋━╋━╋━┫
# ┣━╋━╋━╋━╋━╋━┫
# ┣━╋━╋━╋━╋━╋━┫
# ┣━╋━╋━╋━╋━╋━┫
# ┗━┻━┻━┻━┻━┻━┛


module Q31
  # 幅優先探索でスタートから折り返し地点まで最短経路を探す。
  # 経路を保存しておき、その経路を使えないものとして、袋に使える経路がいくつになるかを探す。

  N = 6
  START = [0, 0]
  TURN = [6, 6]
  DIRECTIONS = [[0, -1], [0, 1], [-1, 0], [1, 0]]
  @@map = Array.new((N + 1) * (N + 1), 99)

  def self.main
    # 最短経路探索
    search_path
    # 移動経路のログを取って復路との組み合わせを数える
    puts count_one_stroke_path
  end

  def self.search_path
    search_queue = [START]
    depth = 0

    loop do
      next_search_queue = search_next(search_queue, depth)
      break if next_search_queue.empty?
      search_queue = next_search_queue
      depth += 1
    end
  end

  def self.search_next(search_queue, depth)
    next_search_queue = []
    until search_queue.empty?
      position = search_queue.shift
      next if square_map(*position) <= depth
      update_square_map(*position, depth)

      next_search_queue << find_next_position(position)
    end
    next_search_queue.flatten(1)
  end

  def self.count_one_stroke_path
    next_path(START, [TURN, START])
  end

  def self.next_path(current_pos, destinations, log = [])
    goal = destinations.first

    # 目的地に到着した場合、次の目的地を設定
    if current_pos == goal
      destinations = destinations[1..]
      goal = destinations&.first
    end
    return 1 if goal.nil?

    # 深さ優先で発見済みの最短経路をたどる
    depth, goal_depth = square_map(*current_pos), square_map(*goal)
    step = goal_depth > depth ? 1 : -1
    next_positions = find_next_position(current_pos).filter {|xy| square_map(*xy) == depth + step}
    next_positions.sum do |next_pos|
      path = [current_pos, next_pos].sort
      next 0 if log.include?(path)

      log << path
      path_pattern = next_path(next_pos, destinations, log)
      log.delete(path)

      path_pattern
    end
  end

  def self.find_next_position(xy)
      next_position = DIRECTIONS.map do |d|
        d.zip(xy).map {|d_xy| d_xy.inject(:+)}
      end
      next_position.filter {|pos| valid_position?(pos)}
  end

  def self.square_map(x, y)
    @@map[y * (N + 1) + x]
  end

  def self.update_square_map(x, y, v)
    @@map[y * (N + 1) + x] = v
  end

  def self.valid_position?(p)
    p.all? {|i| (0..N).include?(i)}
  end
end

Q31.main
