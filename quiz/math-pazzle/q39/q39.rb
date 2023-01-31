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
  @@board_turn = Array.new(0b1111_1111_1111_1111)

  def self.main
    @@switch = switch_effect_mask.freeze
    puts find_most_complex_state
  end

  def self.find_most_complex_state
    next_queue = [[0b0000_0000_0000_0000, 0]]

    until next_queue.empty?
      prev_board, prev_turn = next_queue.shift
      @@switch.each do |switch_mask|
        board = switch_mask ^ prev_board
        turn = prev_turn + 1

        if @@board_turn[board].nil?
          @@board_turn[board] = turn
          next_queue << [board, turn]
        end
      end
    end

    @@board_turn.max
  end

  def self.switch_effect_mask
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
