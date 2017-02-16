gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require 'faraday'


class MyWebApplicationTest < Minitest::Test

  def test_it_returns_a_response
    response = Faraday.get 'http://127.0.0.1:9292'

    assert_equal "<pre>GET / HTTP/1.1Host: localhost:9292User-Agent: curl/7.51.0Accept: */*</pre>", response.body
  end

  def test_it_returns_a_response_at_root
    response = Faraday.get 'http://127.0.0.1:9292'

    assert_equal "<pre>GET / HTTP/1.1Host: localhost:9292User-Agent: curl/7.51.0Accept: */*</pre>", response.body
  end

  def test_it_returns_a_response_for_datetime #can't test b/c response constantly changes?
    response = Faraday.get 'http://127.0.0.1:9292/datetime'
    current_time = Time.now.strftime("%H:%M%p on %A, %B %-d, %Y")

    assert_equal current_time, response.body
  end

  def test_does_the_word_search_work
    response = Faraday.get 'http://127.0.0.1:9292/word_search?word=test'

    assert_equal "Test is a known word", response.body
  end

  def test_it_returns_a_response_for_hello
skip
    response = Faraday.get 'http://127.0.0.1:9292/hello'

    assert_equal "Hello World! (#{counter})\n", response.body
  end

  def test_it_returns_a_response_for_shutdown
skip
    response = Faraday.get 'http://127.0.0.1:9292/shutdown'

    assert_equal "Total Requests: #{counter_requests}", response.body
  end #also can't test b/c total requests varies?

end
