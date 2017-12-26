require './lib/game'
require_relative 'test_helper'

class GameTest < Minitest::Test

  def test_it_exists
    game = Game.new
    assert_instance_of Game, game
  end

  def test_it_can_assign_a_user_guess
    game = Game.new
    game.user_guess = 5
    assert_equal 5, game.user_guess
  end

  def test_it_can_assign_a_user_guess_string
    game = Game.new
    game.user_guess = "5"
    assert_equal "5", game.user_guess
  end

  def test_it_can_assign_a_high_or_low
    game = Game.new
    game.high_or_low = "was too low!"
    assert_equal "was too low!", game.high_or_low
  end

  def test_it_can_check_high_or_low
    game = Game.new
    game.user_guess = 5
    game.secret_number = 4
    game.check_high_or_low
    assert_equal "was too high!", game.high_or_low
  end

end
