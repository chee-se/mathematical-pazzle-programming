#frozen_string_literal: true

# コインを賭けて、勝てば＋１枚、負ければ－１枚の賭博をする
# 10枚のコインから始めて、24回ゲームを終えて手元にコインが残っているのは何通りか

module Q23

  # 勝ち数と負け数をカウントして、勝ち数 + 手持ちコイン数＜負け数となるパターンを除外して考えれば良い。
  N = 24
  START_COIN = 10

  def self.main
    puts game(0, 0)
  end

  def self.game(win, lose)
    return 0 if win + 10 < lose
    return 1 if win + lose == 24
    game(win + 1, lose) + game(win, lose + 1)
  end
end

Q23.main
