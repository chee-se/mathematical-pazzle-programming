#frozen_string_literal: true

# 100枚のカードを裏向きに並べ、一人目が二枚目から一枚おきにカードをめくる。
# 次に、二人目が三枚目からカードを二枚おきにめくる。
# これを繰り返したとき、最後に裏向きになっているカードは何枚目か、すべて求めよ

module Q03

  def self.main
    cards = Array.new(100, false)
    (1..99).each {|n| reverse_card(cards, n) }
    reversed_cards = cards.map.with_index(1) {|card, n| card ? nil: n}.compact
    puts reversed_cards.to_s
  end

  # 引数 nth_person は 1 から始まることに注意
  def self.reverse_card(cards, nth_person)
    start_index = nth_person
    step = nth_person + 1
    start_index.step(cards.size - 1, step) {|i| cards[i] = !cards[i]}
  end
end

Q03.main
