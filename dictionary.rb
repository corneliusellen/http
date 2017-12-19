class Dictionary

  def initialize(word)
    @word = word
  end

  def file_opener
    
  end

  def checker
    if file_opener.include?(@word)
      "#{@word} is a known word"
    else
      "SORRY, #{word} is not a known word"
    end
  end

end
