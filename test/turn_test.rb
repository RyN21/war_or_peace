require 'minitest/autorun'
require 'minitest/pride'
require './lib/deck'
require './lib/card'
require './lib/player'
require './lib/turn'
require 'pry'

class TurnTest < Minitest::Test
  def setup
    @card1 = Card.new(:heart, 'Jack', 11)
    @card2 = Card.new(:heart, '10', 10)
    @card3 = Card.new(:heart, '9', 9)
    @card4 = Card.new(:diamond, 'Jack', 11)
    @card5 = Card.new(:heart, '8', 8)
    @card6 = Card.new(:diamond, 'Queen', 12)
    @card7 = Card.new(:heart, '3', 3)
    @card8 = Card.new(:diamond, '2', 2)
    @card9 = Card.new(:heart, 'Queen', 12)

    @deck1 = Deck.new([@card1, @card2, @card5, @card8])
    @deck2 = Deck.new([@card3, @card4, @card6, @card7])

    @player1 = Player.new("Megan", @deck1)
    @player2 = Player.new("Aurora", @deck2)

    @turn = Turn.new(@player1, @player2)
  end

  def test_it_exists
    assert_instance_of Turn, @turn
  end

  def test_player1_exists
    assert_equal @player1, @turn.player1
  end

  def test_player2_exists
    assert_equal @player2, @turn.player2
  end

  def test_spoils_of_war_exists
    assert_equal [], @turn.spoils_of_war
  end

  def test_turn_type
    assert_equal :basic, @turn.type
  end

  def test_winner
    assert_equal @player1, @turn.winner
  end

  def test_pile_cards_if_basic
    assert_equal :basic, @turn.type
    @turn.pile_cards
    assert_equal [@card1, @card3], @turn.spoils_of_war
  end

  def test_pile_cards_if_war
    @deck3 = Deck.new([@card4, @card2, @card5, @card8])
    @deck4 = Deck.new([@card1, @card3, @card6, @card7])

    @player1 = Player.new("Megag", @deck3)
    @player2 = Player.new("Aurora", @deck4)

    @turn = Turn.new(@player1, @player2)
    assert_equal :war, @turn.type
    @turn.pile_cards
    assert_equal [@card4, @card2, @card5, @card1, @card3, @card6], @turn.spoils_of_war
  end

  def test_pile_cards_if_mut_assured_destruction
    @deck5 = Deck.new([@card4, @card2, @card9, @card8])
    @deck6 = Deck.new([@card1, @card3, @card6, @card7])
    @player1 = Player.new("Megag", @deck5)
    @player2 = Player.new("Aurora", @deck6)

    @turn = Turn.new(@player1, @player2)
    assert_equal :mutually_assured_destruction, @turn.type
    @turn.pile_cards
    assert_equal [@card8], @player1.deck.cards
    assert_equal [@card7], @player2.deck.cards
  end

  def test_it_if_awards_spoils
    @deck3 = Deck.new([@card4, @card2, @card5, @card8])
    @deck4 = Deck.new([@card1, @card3, @card6, @card7])

    @player1 = Player.new("Megag", @deck3)
    @player2 = Player.new("Aurora", @deck4)

    @turn = Turn.new(@player1, @player2)
    assert_equal :war, @turn.type
    assert_equal "Aurora", @turn.winner.name
    @turn.pile_cards
    assert_equal [@card4, @card2, @card5, @card1, @card3, @card6], @turn.spoils_of_war
    @turn.award_spoils
    assert_equal [@card7, @card4, @card2, @card5, @card1, @card3, @card6], @player2.deck.cards
  end
end
