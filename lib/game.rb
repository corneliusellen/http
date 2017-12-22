class Game

  def initialize(client)
    @client.client
  end

  def start
    body = "Good luck!"
    response = Response.new(client, body)
    response.send_response
  end

end
