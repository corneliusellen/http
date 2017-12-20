class Request

  attr_reader :number_of_requests,
              :request_log,
              :verb,
              :path,
              :word,
              :user_guess,
              :protocol,
              :host,
              :port,
              :origin,
              :accept

  def initialize(client)
    @request_log = []
    @client = client
  end

  def document_request
    while line = @client.gets and !line.chomp.empty?
      @request_log << line.chomp
    end
    parse_request
  end

  def parse_request
    @verb = @request_log[0].split(" ")[0]
    @path = @request_log[0].split(" ")[1]
    @word = @request_log[0].split(" ")[1].split("=")[1]
    @user_guess = (@client.read(@request_log[3].split(": ")[1].to_i)).split("\r\n")[3].to_i
    @protocol = @request_log[0].split(" ")[2]
    @host = @request_log[1].split(" ")[1]
    @port = @request_log[1].split(":")[2]
    @origin = @request_log[1].split(" ")[1]
    @accept = @request_log[6].split(" ")[1]
  end

end
