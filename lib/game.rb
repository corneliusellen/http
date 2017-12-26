class Gam

  attr_accessor :number_of_guesses,
                :user_guess,
                :high_or_low,
                :secret_number

  def assign_user_guess(request)
    @number_of_guesses = number_of_guesses_fake
    @number_of_guesses += 1
    @user_guess = request.user_guess
  end


  def guess_checker(request)
    assign_user_guess(request)
    check_high_or_low
  end

  def check_high_or_low
    if @user_guess < @secret_number
      @high_or_low = "was too low!"
    elsif @user_guess > @secret_number
      @high_or_low = "was too high!"
    elsif @user_guess == @secret_number
      @high_or_low = "is correct!!!"
    end
  end


end
