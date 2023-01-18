#frozen_string_literal: true

# 以下の国名のリストでしりとりをした時、最も長く続く順番を求めよ。
# 大文字と小文字は区別しないこと。

COUNTRIES = %w(Brazil Croatia Mexico Cameroon Spain Netherlands Chile Australia Colombia Greece Cote\ d^voire Japan Uruguay Costa\ Rica England
                Italy Swizerland Ecuador France Houndura Argentina Bosnia\ and\ Herzegovina Iran Nigeria Germany Portugal Ghana USA Belgium Algeria Russia Korea\ Republic)

module Q14
  def self.main
    COUNTRIES.map!(&:upcase)
    results = word_chain([], COUNTRIES).each{|chain| p chain}
  end

  def self.word_chain(country_chain, countries)
    chain_tail = country_chain.last&.slice(-1)
    results = countries.map {|country|
      word_chain(country_chain + [country], countries - [country]) if chain_tail.nil? || country.start_with?(chain_tail)
    }.compact.flatten(1)

    return [country_chain] if results.empty?

    max_length = results.map(&:size).max
    results = results.filter {|chain| chain.size == max_length}
  end
end

Q14.main
