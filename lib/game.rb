class Game

  attr_accessor :number_of_guesses,
                :user_guess,
                :high_or_low,
                :secret_number

  def initialize
    @secret_number = rand(0..5)
    @number_of_guesses = 0
    @user_guess = nil
    @high_or_low = nil
  end

  def assign_user_guess(request)
    @number_of_guesses += 1
    @user_guess = request.user_guess
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

  def guess_checker(request)
    assign_user_guess(request)
    check_high_or_low
  end

end
