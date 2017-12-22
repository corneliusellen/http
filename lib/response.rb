require_relative 'request'

class Response

  def initialize(client, request, body = nil)
    @client = client
    @request = request
    @body = body
  end

  def header
    ["http/1.1 200 ok",
    "date: #{Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')}",
    "server: ruby",
    "content-type: text/html; charset=iso-8859-1",
    "content-length: #{output.length}\r\n\r\n"].join("\r\n")
  end

  def output
    "<html><head></head><body>#{@body}<footer>#{footer}</footer></body></html>"
  end

  def footer
    "<pre>" + "\r\n" +
    ["Verb: #{@request.verb}",
    "Path: #{@request.path}",
    "Protocol: #{@request.protocol}",
    "Host: #{@request.host}",
    "Origin: #{@request.origin}"].join("\r\n") +
    "\r\n" + "</pre>"
  end

  def send_response
    @client.puts header
    @client.puts output
  end

  def header_redirect_start_game
    ["http/1.1 302 Moved Permanently",
    "Location: http://127.0.0.1:9292/start_game",
    "date: #{Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')}",
    "server: ruby",
    "content-type: text/html; charset=iso-8859-1",
    "content-length: #{output.length}\r\n\r\n"].join("\r\n")
  end

  def send_redirect_start_game
    @client.puts header_redirect_start_game
    @client.puts output
  end

  def header_redirect_game
    ["http/1.1 302 Moved Permanently",
    "Location: http://127.0.0.1:9292/game",
    "date: #{Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')}",
    "server: ruby",
    "content-type: text/html; charset=iso-8859-1",
    "content-length: #{output.length}\r\n\r\n"].join("\r\n")
  end

  def send_redirect_game
    @client.puts header_redirect_game
    @client.puts output
  end

  def header_moved
    ["http/1.1 404 Not Found",
    "date: #{Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')}",
    "server: ruby",
    "content-type: text/html; charset=iso-8859-1",
    "content-length: #{output_moved.length}\r\n\r\n"].join("\r\n")
  end

  def output_moved
    "<html><head></head><body>#{"Page does not exist"}<footer>#{footer}</footer></body></html>"
  end

  def send_moved
    @client.puts header_moved
    @client.puts output_moved
  end

  def header_forbidden
    ["http/1.1 403 Forbidden",
    "date: #{Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')}",
    "server: ruby",
    "content-type: text/html; charset=iso-8859-1",
    "content-length: #{output_forbidden.length}\r\n\r\n"].join("\r\n")
  end

  def output_forbidden
    "<html><head></head><body>#{"Forbidden"}<footer>#{footer}</footer></body></html>"
  end

  def send_forbidden
    @client.puts header_forbidden
    @client.puts output_forbidden
  end

  def header_internal_error
    ["http/1.1 500 Internal Server Error",
    "date: #{Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')}",
    "server: ruby",
    "content-type: text/html; charset=iso-8859-1",
    "content-length: #{output_internal_error.length}\r\n\r\n"].join("\r\n")
  end

  def output_internal_error
    "<html><head></head><body>#{"Internal Server Error"}<footer>#{footer}</footer></body></html>"
  end

  def send_internal_error
    @client.puts header_internal_error
    @client.puts output_internal_error
  end

end
