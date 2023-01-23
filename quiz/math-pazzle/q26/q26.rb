#frozen_string_literal: true

# 10*10のスライドパズルで、右下が空きマスのとき、一番左上のピースを一番右下に持ってくるための最小手数を求めよ。

# ex) 2 * 3 のとき、最小9手
# @: 目的のピース
# O: 空きマス

#  0th    1st    2nd    3rd    4th    5th    6th    7th    8th    9th
# @.. -> @.. -> @O. -> O@. -> .@. -> .@. -> .O. -> ..O -> ... -> ...
# ..O    .O.    ...    ...    O..    .O.    .@.    .@.    .@O    .O@

module Q26
  # 2nd から 8thの変化で、目的のピースは右と左に1マスずつ移動し、空きマスとピースの位置関係は同じなので、
  # 初手のセットアップから6手で2マス移動すると考える。
  # 水平方向と垂直方向の移動量が同等の場合のみ成立することに注意

  N = 10
  M = 10
  GOAL = [N - 1, M - 1]
  @@target = [0, 0]
  @@blank = [N - 1, M - 1]

  def self.main
    # セットアップ：空きマスを(0, 1)まで移動させる
    setup_turn = (@@blank[0] - 0) + (@@blank[1] - 1)

    # 最小手数の定跡を使って(8, 8)まで移動させる
    repeat_turn = 8 * standard_move

    # 最後に、2ndの位置関係から6thの手順をたどることで(9, 9)に移動させる
    finish_turn = 4

    puts setup_turn + repeat_turn + finish_turn
  end

  def self.standard_move
    # 空きますを目的ピースの右隣につけた状態から
    # 右に1マス、下に1マス移動させる手数
    6
  end
end

Q26.main
