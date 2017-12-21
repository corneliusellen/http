require_relative 'request'

class Response < Request

  def initialize(client, body)
    @client = client
    @body = body
  end

  def header
    ["http/1.1 200 ok",
    "date: #{Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')}",
    "server: ruby",
    "content-type: text/html; charset=iso-8859-1",
    "content-length: #{output.length}\r\n\r\n"].join("\r\n")
  end

  def footer
    "<pre>" + "\r\n" +
    ["Verb: #{@verb}",
    "Path: #{@path}",
    "Protocol: #{@protocol}",
    "Host: #{@host}",
    "Port: #{@port}",
    "Origin: #{@origin}",
    "Accept: #{@accept}"].join("\r\n") +
    "\r\n" + "</pre>"
  end

  def output
    "<html><head></head><body>#{@body}<footer>#{footer}</footer></body></html>"
  end

  def send_response
    @client.puts header
    @client.puts output
  end

  def redirect_header
    ["http/1.1 302 Moved Permanently",
    "Location: http://127.0.0.1:9292/game",
    "date: #{Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')}",
    "server: ruby",
    "content-type: text/html; charset=iso-8859-1",
    "content-length: #{output.length}\r\n\r\n"].join("\r\n")
  end

  def send_redirect
    @client.puts redirect_header
    @client.puts output
  end

end
