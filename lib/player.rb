
class Player
  attr_reader :name, :deck

  def initialize(name, deck)
    @name = name
    @deck = deck
    @player_loses = false
  end

  def has_lost?
    if @deck.cards == []
      @player_loses = true
    else
      @player_loses
    end
  end

  def remove_card
     @deck.cards.slice!(0)
  end

end
