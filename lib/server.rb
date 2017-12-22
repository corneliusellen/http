require 'socket'
require_relative 'dictionary'
require_relative 'game'
require_relative 'request'
require_relative 'response'

class Server

  def initialize
    @server = TCPServer.new(9292)
    @number_of_requests = 0
  end

  def start
    client = @server.accept
    receive_request(client)
  end

  def receive_request(client)
    request = Request.new(client)
    request.document_request
    @number_of_requests += 1
    verb_finder(client, request)
    client.close
  end

  def verb_finder(client, request)
    if request.verb == "GET"
      path_finder_get(client, request)
    elsif request.verb == "POST"
      path_finder_post(client, request)
    else
      raise ArgumentError
    end
  end

  def path_finder_get(client, request)
    if request.path == "/"
      main(client, request)
    elsif request.path == "/hello"
      hello(client, request)
    elsif request.path == "/datetime"
      date_time(client, request)
    elsif request.path == "/shutdown"
      shut_down(client, request)
    elsif request.path.include?("/word_search")
      word_search(client, request)
    elsif request.path == "/start_game"
      start_game(client, request)
    elsif request.path == "/game"
      game_status(client, request)
    else
      respond_moved(client, request)
    end
  end

  def path_finder_post(client, request)
    if request.path == "/start_game"
      post_start_game(client, request)
    elsif request.path == "/game"
      make_a_guess(client, request)
    else
      respond_moved(client, request)
    end
  end

  def respond(client, request, body)
    response = Response.new(client, request, body)
    response.send_response
  end

  def main(client, request)
    respond(client, request, body = nil)
    start
  end

  def hello(client, request)
    body = "Hello, World!(#{@number_of_requests})"
    respond(client, request, body)
    start
  end

  def date_time(client, request)
    t = Time.new
    body = "#{t.strftime("%I")}:#{t.strftime("%M")}#{t.strftime("%p")} on #{t.strftime("%A")}, #{t.strftime("%B")} #{t.strftime("%d")}, #{t.strftime("%Y")}"
    respond(client, request, body)
    start
  end

  def shut_down(client, request)
    body = "Total requests: #{@number_of_requests}"
    respond(client, request, body)
  end

  def word_search(client, request)
    body = Dictionary.new(request.word).checker
    respond(client, request, body)
    start
  end

  def start_game(client, request)
    @game = Game.new
    body = "Good luck!"
    respond(client, request, body)
    start
  end

  def game_status(client, request)
    body = "Your last guess was #{@game.user_guess} and it #{@game.high_or_low}. You have made #{@game.number_of_guesses} guesses."
    respond(client, request, body)
    start
  end

  def make_a_guess(client, request)
    @game.guess_checker(request)
    link = "http://127.0.0.1:9292/game"
    respond_redirect(client, request, link)
    start
  end

  def post_start_game(client, request)
    link = "http://127.0.0.1:9292/start_game"
    respond_redirect(client, request, link)
    start
  end

  def respond_redirect(client, request, link)
    response = Response.new(client, request)
    response.send_redirect(link)
    start
  end

  def respond_forbidden(client, request)
    response = Response.new(client, request)
    response.send_forbidden
    start
  end

  def respond_moved(client, request)
    response = Response.new(client, request)
    response.send_moved
    start
  end

end
