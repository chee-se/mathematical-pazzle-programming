#frozen_string_literal: true

# n行n列の行列に◯と✕を配置し、各行、列ごとに◯をカウントして記録をつける。
# この記録から配置を復元したとき、配置パターンが１つに限られるもの記録の数を答えよ。
# n=4とする

module Q47

  # 配置を全探索する

  class << self
    def main
      counter = [0, 1].repeated_permutation(4 * 4).map.with_object(Hash.new(0)) { |pattern, counter| counter[to_record(pattern)] += 1 }
      puts counter.filter {|k, v| v == 1}.size
    end

    def to_record(pattern)
      [
        pattern[0]  + pattern[1]  + pattern[2]  + pattern[3],
        pattern[4]  + pattern[5]  + pattern[6]  + pattern[7],
        pattern[8]  + pattern[9]  + pattern[10] + pattern[11],
        pattern[12] + pattern[13] + pattern[14] + pattern[15],

        pattern[0]  + pattern[4]  + pattern[8]  + pattern[12],
        pattern[1]  + pattern[5]  + pattern[9]  + pattern[13],
        pattern[2]  + pattern[6]  + pattern[10] + pattern[14],
        pattern[3]  + pattern[7]  + pattern[11] + pattern[15],
      ]
    end
  end
end

Q47.main
