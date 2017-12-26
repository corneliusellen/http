class Dictionary

  attr_reader :word

  def initialize(word)
    @word = word
  end

  def checker
    file_name = File.readlines("/usr/share/dict/words")
    if file_name.include?("#{@word}\n")
      "#{@word} is a known word"
    else
      "SORRY, #{word} is not a known word"
    end
  end

end
