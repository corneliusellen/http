require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require_relative 'dictionary'

class DictionaryTest < Minitest::Test

  def test_can_take_a_word
    dictionary = Dictionary.new("girl")

    assert_equal "girl", dictionary.word
  end

  def test_it_can_locate_word_in_dictionary
    dictionary = Dictionary.new("girl")

    assert_equal "girl is a known word", dictionary.checker
  end

end
