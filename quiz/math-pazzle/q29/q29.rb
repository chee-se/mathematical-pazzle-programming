#frozen_string_literal: true

# 1Ωの抵抗を10個使って、黄金比「1.61803399887」に可能な限り抵抗値を近づけて、有効数字小数点以下10桁で答えよ。


# a, b の抵抗を直列に繋いだ場合、抵抗値は a + b
# ────■───■──── -> 1 + 1 = 2Ω

# a, b を並列に繋いだ場合、抵抗値は逆数の和の逆数 (a^-1 + b^-1)^-1
#    ┌──■──┐
# ───┤     ├───
#    └──■──┘

module Q29
  # 直列抵抗と並列抵抗を配列で作る

  # 抵抗の基本構造：単体の抵抗
  # resistance = {
  #   ohm: 1
  # }

  # 抵抗の基本構造：並列の抵抗
  #    ┌──■──┐
  # ───┼──■──┼───
  #    └──■──┘
  # resistance = {
  #   parallel: [resistance, resistance, resistance],
  #   ohm: ohm
  # }

  # 抵抗の基本構造：直列の抵抗
  # ────■───■───■────
  # resistance = {
  #   series: [resistance, resistance, resistance],
  #   ohm: ohm
  # }

  GOAL = 1.61803399887
  N = 10
  RESISTANCE_VALUE = 1

  def self.main
    result = add_resistances(N, GOAL)
    puts result[:ohm].to_f
  end

  def self.add_resistances(n, ohm_goal)
    resistance = new_resistance(RESISTANCE_VALUE)

    (1...n).each do |_|
      new_resistance_ohm = RESISTANCE_VALUE

      # すべての追加パターンを取得
      new_ohms = calc_new_resistance(new_resistance_ohm, resistance)

      # 最も抵抗が理想に近くなるパターンで追加
      path, new_ohm = new_ohms.min_by {|_, ohm| (GOAL - ohm).abs}
      add_new_resistance(new_resistance_ohm, resistance, path)
    end
    resistance
  end

  def self.add_new_resistance(ohm, resistance, path)
    # path の指定に従って追加対象の抵抗まで層を深掘りする
    recalc_resistance = path[0..-2].each.with_object([resistance]) {|p, arr| arr << resistance = resistance[p]}

    case path.last
    when :series
      add_as_series_resistance(ohm, resistance)
    when :parallel
      add_as_parallel_resistance(ohm, resistance)
    end

    # 追加された抵抗によって変化した新しい抵抗値を計算しておく
    recalc_resistance.reverse_each {|r| refresh_ohm(r) if r.is_a?(Hash)}
  end

  def self.add_as_series_resistance(ohm, resistance)
    series = resistance[:series]

    # 直列構造の抵抗の場合、直列部分に追加
    unless series.nil?
      series << new_resistance(ohm)
      resistance[:ohm] += ohm
      return resistance
    end

    # 直列構造ではない場合、新しい直列構造の抵抗を作って、そこに ohm と resistance を直列につなぐ
    #
    # resistance を含む参照ツリーを維持するために、新規ハッシュを作って返す代わりに
    # resistance をクローンして内容を保持しつつ、書き換えた resistance を返す
    # return {
    #   series: [new_resistance(ohm), resistance],
    #   ohm: ohm + resistance[:ohm]
    # }
    clone = resistance.clone
    resistance[:series] = [new_resistance(ohm), clone]
    resistance[:ohm] = ohm + clone[:ohm]
    resistance.delete(:parallel)
    resistance
  end

  def self.add_as_parallel_resistance(ohm, resistance)
    parallel = resistance[:parallel]

    # 並列構造の抵抗の場合、並列部分に追加
    unless parallel.nil?
      parallel << new_resistance(ohm)
      resistance[:ohm] = calc_parallel_ohm_value(*parallel.map {|p| p[:ohm]})
      return resistance
    end

    # 並列構造ではない場合、新しい並列構造の抵抗を作って、そこに ohm と resistance を並列につなぐ
    #
    # resistance を含む参照ツリーを維持するために、新規ハッシュを作って返す代わりに
    # resistance をクローンして内容を保持しつつ、書き換えた resistance を返す
    # return {
    #   parallel: [new_resistance(ohm), resistance],
    #   ohm: ohm + resistance[:ohm]
    # }
    clone = resistance.clone
    resistance[:parallel] = [new_resistance(ohm), clone]
    resistance[:ohm] = calc_parallel_ohm_value(ohm, clone[:ohm])
    resistance.delete(:series)
    resistance
  end

  def self.new_resistance(ohm)
    {ohm: ohm}
  end

  def self.calc_new_resistance(ohm, resistance, path = [])
    # 直列、並列に接続した場合を試算
    series_ohm = [path + [:series], calc_as_series_resistance(ohm, resistance)]
    parallel_ohm = [path + [:parallel], calc_as_parallel_resistance(ohm, resistance)]

    # 内部の直列抵抗の一つに接続した場合を試算
    series = resistance[:series] || []
    inner_series_ohm = series.sum {|r| r[:ohm]}
    new_inner_series_ohm = series.map.with_index do |s, i|
      calc_new_resistance(ohm, s, path + [:series] + [i]).map do |new_path, new_ohm|
        [new_path, new_ohm + inner_series_ohm - series[i][:ohm]]
      end
    end.flatten(1)

    # 内部の並列抵抗の一つに接続した場合を試算
    parallel = resistance[:parallel] || []
    inner_parallel_ohm = parallel.empty? ? nil : calc_parallel_ohm_value(*parallel.map {|r| r[:ohm]})
    new_inner_parallel_ohm = parallel.map.with_index do |s, i|
      calc_new_resistance(ohm, s, path + [:parallel] + [i]).map do |new_path, new_ohm|
        [new_path, calc_parallel_ohm_value(new_ohm, inner_parallel_ohm, -parallel[i][:ohm])]
      end
    end.flatten(1)

    [series_ohm, parallel_ohm] + new_inner_series_ohm + new_inner_parallel_ohm
  end

  def self.calc_as_series_resistance(ohm, resistance)
    ohm + resistance[:ohm]
  end

  def self.calc_as_parallel_resistance(ohm, resistance)
    calc_parallel_ohm_value(ohm, resistance[:ohm])
  end

  def self.calc_parallel_ohm_value(*ohms)
    (ohms.sum {|ohm| ohm ** -1}) ** -1
  end

  def self.refresh_ohm(resistance)
    series_sum = resistance[:series].sum {|r| r[:ohm]} unless resistance[:series].nil?
    parallel_sum = calc_parallel_ohm_value(*resistance[:parallel].map {|r| r[:ohm]}) unless resistance[:parallel].nil?

    resistance[:ohm] = series_sum if series_sum && series_sum > 0
    resistance[:ohm] = parallel_sum if parallel_sum && parallel_sum > 0
  end
end

Q29.main
