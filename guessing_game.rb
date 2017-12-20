class Guess

  def initialize
    @secret_number = rand(0..5)
    @guesses = 0
  end

  def guessing_loop
    user_guess = gets.chomp.to_i
    until user_guess == x
      guesses = guesses + 1
      if
        user_guess < x
        puts "Guess higher!"
      else
          puts "Guess lower!"
      end
      user_guess = gets.chomp.to_i
    end
    puts "You guessed the right number #{x} in #{guesses} guesses!"
  end

end 
