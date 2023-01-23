#frozen_string_literal: true

# 6＊4マスの碁盤の目状の道路を左折しかできない車が通る。
# 左下から右上までの経路が何通りあるか求めよ。ただし、経路は交差しても良いが同じ道を二度通ってはいけない。

# ex) 以下は３＊２マスの例
# S：スタート、G：ゴール
#
# ┏━┳━┳━G
# ┣━╋━╋━┫
# S━┻━┻━┛

module Q27
  # (0, 0)から（6, 4）を目指す。
  # 移動経路のログを取り、既出の移動があったら中止とする

  # 実装メモ
  # 手本によくある配列をハッシュキーにする方法を真似て実装してみたが、再帰の中で状態を管理する共通オブジェクト @@log を常に書き換えているので、バグったときの追跡可能性がヤバい。業務向きの実装ではない気がする
  # ハッシュのキーに配列を使うのも業務向きではない。ruby が配列の値を見て同一性を判定しているとはいえ。

  @@log = {}

  W, H = 6, 4
  START = [0, 0]
  GOAL = [6, 4]

  UP, LEFT, DOWN, RIGHT = 0, 1, 2, 3

  def self.main
    puts drive(START, RIGHT) # 右向きにスタートすることで、右方向と上方向に進み出す
  end

  def self.drive(pos, direction)
    return 1 if pos == GOAL

    # 直進、左折
    [direction, turn_left(direction)].sum do |next_direction|
      next_pos, next_road = move(pos, next_direction)
      next 0 unless valid_pos?(next_pos)

      # 道路の使用履歴に侵入方向は関係ないので正規化する
      nr = next_road.dup
      next_road.sort!
      next 0 if @@log[next_road]

      @@log[next_road] = true
      route = drive(next_pos, next_direction)
      @@log[next_road] = false

      route
    end
  end

  def self.turn_left(direction)
    (direction + 1) % 4
  end

  def self.move(pos, direction)
    w, h = pos
    next_pos = case direction
    when UP
      [w, h + 1]
    when LEFT
      [w - 1, h]
    when DOWN
      [w, h - 1]
    when RIGHT
      [w + 1, h]
    end

    [next_pos, [pos, next_pos]]
  end

  def self.valid_pos?(pos)
    w, h = pos
    # マス目に対して座標は1多いので 0 <= w <= W
    (0..W).include?(w) && (0..H).include?(h)
  end
end

Q27.main
