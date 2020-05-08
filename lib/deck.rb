
class Deck
  attr_reader :cards

  def initialize(cards)
    @cards = cards
  end

  def rank_of_card_at(index)
    @cards[index].rank
  end

  def high_ranking_cards()
    @cards.map do |card|
      if card.rank >= 11
        card
      end
    end.compact
  end

  def percent_high_ranking()
    percent_of_high_rank = high_ranking_cards.length.to_f / @cards.length * 100.00
    percent_of_high_rank.round(2)
  end

  def remove_card()
    @cards.shift
    @cards
  end

  def add_card(card)
    @cards << card
  end
end
