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
      guess_again(client, request)
    elsif (request.verb == "POST") && (request.path == "/game")
      guess_again
    else
      @client.puts output
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

  # def begin_game(client, request)
  #   guess = request.user_guess
  #   guessing_game = GuessingGame.new(guess, @secret_number)
  #   response = guessing_game.assess_number
  # end
  #
  # def guess_again
  #   response = "Your guess was #{@user_guess} and it was #{begin_game}"
  #   output = "<html><head></head><body>#{response}<footer>#{footer}</footer></body></html>"
  #   @client.puts output
  #   start
  # end

end
