require 'socket'
require_relative 'dictionary'
class Server

  def initialize
    @server = TCPServer.new(9292)
    @number_of_requests = 0
    @client
    @request_log
  end

  def start
    @client = @server.accept
    @request_log = []
    while line = @client.gets and !line.chomp.empty?
      @request_log << line.chomp
    end
    @number_of_requests += 1
    @client.puts header
    # require 'pry'; binding.pry
    path_finder
    @client.close
  end

  def path_finder
    if @request_log[0].split(" ")[1] == "/hello"
      hello
    elsif @request_log[0].split(" ")[1] == "/datetime"
      date_time
    elsif @request_log[0].split(" ")[1] == "/shutdown"
      shut_down
    elsif @request_log[0].split(" ")[1].include?("/word_search")
      word_search
    elsif (@request_log[0].split(" ")[0] == "POST") && (@request_log[0].split(" ")[1] == "/start_game")
      start_game
    elsif (@request_log[0].split(" ")[0] == "POST") && (@request_log[0].split(" ")[1] == "/game")
      begin_game
    elsif (@request_log[0].split(" ")[0] == "GET") && (@request_log[0].split(" ")[1] == "/game")
      guess_again
    else
      @client.puts output
      start
    end
  end

  def hello
    response = "Hello, World!(#{@number_of_requests})"
    output = "<html><head></head><body>#{response}<footer>#{footer}</footer></body></html>"
    @client.puts output
    start
  end

  def date_time
    t = Time.new
    response = "#{t.strftime("%I")}:#{t.strftime("%M")}#{t.strftime("%p")} on #{t.strftime("%A")}, #{t.strftime("%B")} #{t.strftime("%d")}, #{t.strftime("%Y")}"
    output = "<html><head></head><body>#{response}<footer>#{footer}</footer></body></html>"
    @client.puts output
    start
  end

  def shut_down
    response = "Total requests: #{@number_of_requests}"
    output = "<html><head></head><body>#{response}<footer>#{footer}</footer></body></html>"
    @client.puts output
  end

  def word_search
    response = Dictionary.new(@request_log[0].split(" ")[1].split("=")[1]).checker
    output = "<html><head></head><body>#{response}<footer>#{footer}</footer></body></html>"
    @client.puts output
    start
  end

  def start_game
    response = "Good luck!"
    output = "<html><head></head><body>#{response}<footer>#{footer}</footer></body></html>"
    @client.puts output
    start
  end

  def begin_game
    parse out response to get guess
    send guess to guessing game class with param and get back response
      if resonse is wrong call next method
        if response is right output page
          start
  end

  def guess_again
    response = your guess of (guess) was (too high or low) and youve guessed (this many times)
    start
  end

  def header
    ["http/1.1 200 ok",
    "date: #{Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')}",
    "server: ruby",
    "content-type: text/html; charset=iso-8859-1",
    "content-length: #{output.length}\r\n\r\n"].join("\r\n")
  end

  def output
    "<html><head></head><body><footer>#{footer}</footer></body></html>"
  end

  def footer
    "<pre>" + "\r\n" +
    ["Verb: #{@request_log[0].split("/")[0]}",
    "Path: #{@request_log[0].split(" ")[1]}",
    "Protocol: #{@request_log[0].split(" ")[2]}",
    "Host: #{@request_log[1].split(" ")[1]}",
    "Port: #{@request_log[1].split(":")[2]}",
    "Origin: #{@request_log[1].split(" ")[1]}",
    "Accept: #{@request_log[6].split(" ")[1]}"].join("\r\n") +
    "\r\n" + "</pre>"
  end

end
