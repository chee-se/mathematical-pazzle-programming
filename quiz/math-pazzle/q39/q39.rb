#frozen_string_literal: true

# 4 * 4 のライツアウトパズルで最も手数がかかる初期状態を求め、その回数を表示せよ。
# ただし、パネルを選択した場合、反転するのは十字方向にあるマスすべてとする

# ex) (2, 1) を押した場合
# 0 0 0 0     0 0 1 0
# 0 0 0 0  -> 1 1 1 1
# 0 0 0 0     0 0 1 0
# 0 0 0 0     0 0 1 0

module Q39
  # 全消灯の状態から幅優先探索で変化を収集する。
  # 過去に出たパターンは調査を打ち切り、一番深い変化を探す。

  @@switch = [] # initialize by method
  @@board_pattern = Array.new(0b1111_1111_1111_1111)

  def self.main
    @@switch = switch_effects.freeze
    puts find_most_complex_state
  end

  def self.find_most_complex_state
    depth = 0
    next_queue = [[0b0000_0000_0000_0000, depth]]

    until next_queue.empty?
      board, depth = next_queue.shift
      16.times do |i|
        new_board = @@switch[i] ^ board
        new_depth = depth + 1
        if new_depth < (@@board_pattern[new_board] || Float::INFINITY)
          @@board_pattern[new_board] = new_depth
          next_queue << [new_board, new_depth]
        end
      end
    end

    @@board_pattern.max
  end

  def self.switch_effects
    16.times.map {|i|
      horizontal = 0b0000_0000_0000_1111
      horizontal <<= (3 - i / 4) * 4

      vertical = 0b0001_0001_0001_0001
      vertical <<= (3 - i % 4)

      horizontal | vertical
    }
  end
end

Q39.main
