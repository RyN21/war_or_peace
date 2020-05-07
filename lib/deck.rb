require_relative "./card.rb"

class Deck
  attr_reader :cards

  def initialize(cards)
    @cards = cards
  end

##### STUCK ON THISS
  def rank_of_card_at(cards)
      cards.rank
  end
#this method will take one argument that represents the index
#location of a card to be used (typically 0 or 2) and will return
#the rank of that card


  def high_ranking_cards()
    #this method will return an array of cards in the deck that have a
    #rank of 11 or above (face cards and aces)
  end
  def percent_high_ranking()
    #this method will return the percentage of cards that are high rank
  end

  def remove_card()
    #this method will remove the top card from the deck
  end

  def add_card()
    #this method will add one card to the bottom (end) of the deck
  end
end

card1 = Card.new(:diamond, 'Queen', 12)
card2 = Card.new(:spade, '3', 3)
card3 = Card.new(:heart, 'Ace', 14)

cards = [card1, card2, card3]

deck = Deck.new(cards)

deck.cards
puts cards[2].rank
puts deck.rank_of_card_at(1)
