require 'Faraday'
require './lib/server'
require_relative 'test_helper'

class ServerTest < Minitest::Test

  def test_it_returns_404_when_unknown_path_requested
    response = Faraday.get 'http://127.0.0.1:9292/gobblegobble'
    assert_equal 404, response.status
  end

  def test_start_server_returns_expected_body
    response = Faraday.get 'http://127.0.0.1:9292'
    expected = "<html><head></head><body><footer><pre>\r\nVerb: GET\r\nPath: /\r\nProtocol: HTTP/1.1\r\nHost: Faraday\r\nOrigin: Faraday\r\n</pre></footer></body></html>"
    assert_equal expected, response.body
  end

  def test_returns_200_when_get_hello
    response = Faraday.get 'http://127.0.0.1:9292/hello'
    assert_equal 200, response.status
  end

  def test_returns_200_when_get_datetime
    response = Faraday.get 'http://127.0.0.1:9292/datetime'
    assert_equal 200, response.status
  end

  def test_returns_404_when_post_to_start_server
    response = Faraday.post 'http://127.0.0.1:9292'
    assert_equal 404, response.status
  end

  def test_hello_returns_expected_body
    skip
    response = Faraday.get 'http://127.0.0.1:9292/hello'
    expected = "<html><head></head><body>Hello, World!(#{@number_of_requests})<footer><pre>\r\nVerb: GET\r\nPath: /hello\r\nProtocol: HTTP/1.1\r\nHost: Faraday\r\nOrigin: Faraday\r\n</pre></footer></body></html>"
    assert_equal expected, response.body
  end

  def test_returns_404_when_post_to_hello
    response = Faraday.post 'http://127.0.0.1:9292/hello'
    assert_equal 404, response.status
  end

  def test_datetime_returns_expected_body
    response = Faraday.get 'http://127.0.0.1:9292/datetime'
    t = Time.new
    expected = "<html><head></head><body>#{t.strftime("%I")}:#{t.strftime("%M")}#{t.strftime("%p")} on #{t.strftime("%A")}, #{t.strftime("%B")} #{t.strftime("%d")}, #{t.strftime("%Y")}<footer><pre>\r\nVerb: GET\r\nPath: /datetime\r\nProtocol: HTTP/1.1\r\nHost: Faraday\r\nOrigin: Faraday\r\n</pre></footer></body></html>"
    assert_equal expected, response.body
  end

  def test_returns_200_when_get_datetime
    response = Faraday.get 'http://127.0.0.1:9292/datetime'
    assert_equal 200, response.status
  end

  def test_shut_down_returns_expected_body
    skip
    response = Faraday.get 'http://127.0.0.1:9292/shutdown'
    expected = "<html><head></head><body>Total requests: #{@number_of_requests}<footer><pre>\r\nVerb: GET\r\nPath: /shutdown\r\nProtocol: HTTP/1.1\r\nHost: Faraday\r\nOrigin: Faraday\r\n</pre></footer></body></html>"
    assert_equal expected, response.body
  end

  def test_word_search_returns_expected_body
    response = Faraday.get 'http://127.0.0.1:9292/word_search?word=girl'
    expected = "<html><head></head><body>girl is a known word<footer><pre>\r\nVerb: GET\r\nPath: /word_search?word=girl\r\nProtocol: HTTP/1.1\r\nHost: Faraday\r\nOrigin: Faraday\r\n</pre></footer></body></html>"
    assert_equal expected, response.body
  end

  def test_returns_404_when_post_to_word_search
    response = Faraday.post 'http://127.0.0.1:9292/word_search?word=girl'
    assert_equal 404, response.status
  end

  def test_returns_403_when_post_to_start_game_and_game_started
    skip
    response = Faraday.post 'http://127.0.0.1:9292/start_game'
    assert_equal 302, response.status
    @game_started = true
    response_2 = Faraday.post 'http://127.0.0.1:9292/start_game'
    assert_equal 403, response_2.status
  end


  def test_returns_500_when_get_force_error
    response = Faraday.get 'http://127.0.0.1:9292/force_error'
    assert_equal 500, response.status
  end

end
