require 'socket'
require_relative 'dictionary'
require_relative 'guessing_game'
require_relative 'request'
require_relative 'response'

class Server

  def initialize
    @server = TCPServer.new(9292)
    @number_of_requests = 0
    @secret_number = rand(0..5)
    @number_of_guesses = 0
  end

  def start
    client = @server.accept
    request = Request.new(client)
    request.document_request
    @number_of_requests += 1
    path_finder(client, request)
    client.close
  end

  def path_finder(client, request)
    if request.path == "/hello"
      hello(client)
    elsif request.path == "/datetime"
      date_time(client)
    elsif request.path == "/shutdown"
      shut_down(client)
    elsif request.path.include?("/word_search")
      word_search(client, request)
    elsif (request.verb == "POST") && (request.path == "/start_game")
      start_game(client)
    elsif (request.verb == "GET") && (request.path == "/game")
      guess_status(client, request)
    elsif (request.verb == "POST") && (request.path == "/game")
      guess_status(client, request)
    else
      start
    end
  end

  def hello(client)
    body = "Hello, World!(#{@number_of_requests})"
    response = Response.new(client, body)
    response.send_response
    start
  end

  def date_time(client)
    t = Time.new
    body = "#{t.strftime("%I")}:#{t.strftime("%M")}#{t.strftime("%p")} on #{t.strftime("%A")}, #{t.strftime("%B")} #{t.strftime("%d")}, #{t.strftime("%Y")}"
    response = Response.new(client, body)
    response.send_response
    start
  end

  def shut_down(client)
    body = "Total requests: #{@number_of_requests}"
    response = Response.new(client, body)
    response.send_response
  end

  def word_search(client, request)
    body = Dictionary.new(request.word).checker
    response = Response.new(client, body)
    response.send_response
    start
  end

  def start_game(client)
    body = "Good luck!"
    response = Response.new(client, body)
    response.send_response
    start
  end

  def guess_status(client, request)
    guess = request.user_guess
    body = "Your last guess was #{guess} and it #{make_a_guess(guess)}. You have made #{@number_of_guesses} guesses."
    response = Response.new(client, body)
    response.send_response
    start
  end

  def make_a_guess(guess)
    @number_of_guesses += 1
    guessing_game = GuessingGame.new(guess, @secret_number)
    too_high_or_low_or_correct = guessing_game.assess_number
  end

end
