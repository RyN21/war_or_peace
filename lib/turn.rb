class Turn
  attr_reader :player1, :player2, :spoils_of_war

  def initialize(player1, player2, spoils_of_war = false)
    @player1 = player1
    @player2 = player2
    @spoils_of_war = []
    @type = :basic
    @spoils = 0
  end

  def type
    if @player1.deck.rank_of_card_at(0) == @player2.deck.rank_of_card_at(0) && @player1.deck.rank_of_card_at(2) != @player2.deck.rank_of_card_at(2)
      @type = :war
    elsif @player1.deck.rank_of_card_at(0) == @player2.deck.rank_of_card_at(0) && @player1.deck.rank_of_card_at(2) == @player2.deck.rank_of_card_at(2)
      @type = :mutually_assured_destruction
    else
      @type = :basic
    end
  end

  def winner
    if @type == :basic && @player1.deck.rank_of_card_at(0) > @player2.deck.rank_of_card_at(0)
      @winner = @player1
    elsif @type == :basic && @player1.deck.rank_of_card_at(0) < @player2.deck.rank_of_card_at(0)
      @winner = @player2
    elsif @type == :war && @player1.deck.rank_of_card_at(2) > @player2.deck.rank_of_card_at(2)
      @winner = @player1
    elsif @type == :war && @player1.deck.rank_of_card_at(2) < @player2.deck.rank_of_card_at(2)
      @winner = @player2
    else
      @type = :mutually_assured_destruction
      p "No Winner"
    end
  end

  def pile_cards
    @spoils_of_war = []
    if @type == :basic
      @spoils_of_war << @player1.deck.cards.slice!(0)
      @spoils_of_war << @player2.deck.cards.slice!(0)
    elsif @type == :war
      @spoils_of_war << @player1.deck.cards.slice!(0..2)
      @spoils_of_war << @player2.deck.cards.slice!(0..2)
      @spoils_of_war.flatten!
    else @type == :mutually_assured_destruction
      @player1.deck.cards.slice!(0..2)
      @player2.deck.cards.slice!(0..2)
    end
  end

  def award_spoils
    if @winner == @player1
      @player1.deck.cards << @spoils_of_war.slice!(0..5)
      @player1.deck.cards.flatten!
    end
    if @winner == @player2
      @player2.deck.cards << @spoils_of_war.slice!(0..5)
      @player2.deck.cards.flatten!
    end
  end
end
