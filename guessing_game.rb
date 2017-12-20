class GuessingGame

  def initialize(user_guess, secret_number)
    @secret_number = secret_number
    @guesses = 0
    @user_guess = user_guess
  end

  def guessing_loop
    if @user_guess < @secret_number
      "too low!"
    elsif @user_guess > @secret_number
      "too high!"
    elsif @user_guess == @secret_number
      "correct!!!"
    else
      "shit"
    end
  end

end
