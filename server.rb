require 'socket'
class Server

  def initialize
    @server = TCPServer.new(9292)
    @counter = 0
    @request_log = []
  end

  def start
      client = @server.accept
      while line = client.gets and !line.chomp.empty?
          @request_log << line.chomp
          @counter += 1
      end
    client.puts header
    client.puts output
    client.close
    start
  end

  def output
  response = "<pre>" + "Hello, World!(#{@counter / 9})" + "\r\n" +
  ["Verb: #{@request_log[0].split("/")[0]}",
  "Path: #{@request_log[0].split(" ")[1]}",
  "Protocol: #{@request_log[0].split(" ")[2]}",
  "Host: #{@request_log[1].split(" ")[1]}",
  "Port: #{@request_log[1].split(":")[2]}",
  "Origin: #{@request_log[1].split(" ")[1]}",
  "Accept: #{@request_log[6].split(" ")[1]}"].join("\r\n") +
  "\r\n" + "</pre>"

  "<html><head></head><body>#{response}</body></html>"
  end

  def header
  ["http/1.1 200 ok",
  "date: #{Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')}",
  "server: ruby",
  "content-type: text/html; charset=iso-8859-1",
  "content-length: #{output.length}\r\n\r\n"].join("\r\n")
  end

end
