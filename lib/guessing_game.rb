class GuessingGame

  def initialize(user_guess, secret_number)
    @user_guess = user_guess
    @secret_number = secret_number
  end

  def assess_number
    if @user_guess < @secret_number
      "was too low!"
    elsif @user_guess > @secret_number
      "was too high!"
    elsif @user_guess == @secret_number
      "is correct!!!"
    else
      "shit"
    end
  end

end
