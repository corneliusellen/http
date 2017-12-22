require './lib/dictionary'
require_relative 'test_helper'

class DictionaryTest < Minitest::Test

  def test_it_exists
    dictionary = Dictionary.new("boy")
    assert_instance_of Dictionary, dictionary
  end

  def test_can_take_a_word
    dictionary = Dictionary.new("girl")
    assert_equal "girl", dictionary.word
  end

  def test_it_can_locate_word_in_dictionary
    dictionary = Dictionary.new("girl")
    assert_equal "girl is a known word", dictionary.checker
  end

  def test_it_cannot_locate_word_not_in_dictionary
    dictionary = Dictionary.new("beebopdeedoodle")
    assert_equal "SORRY, beebopdeedoodle is not a known word", dictionary.checker
  end

  def test_it_cannot_locate_number_not_in_dictionary
    dictionary = Dictionary.new(1)
    assert_equal "SORRY, 1 is not a known word", dictionary.checker
  end

  def test_it_cannot_locate_float_not_in_dictionary
    dictionary = Dictionary.new(4.3)
    assert_equal "SORRY, 4.3 is not a known word", dictionary.checker
  end

end
