gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require 'faraday'


class MyWebApplicationTest < Minitest::Test

  def test_it_returns_a_response
    response = Faraday.get 'http://127.0.0.1:9292'

    assert_equal "<pre>GET / HTTP/1.1Host: localhost:9292User-Agent: curl/7.51.0Accept: */*</pre>", response.body
  end

#test the expected responses

#iteration 3: start with a faraday.get 'http://127.0.0.1:9292/word_search?word=test'
# assert_equal 'Test is a known word'

# Faraday.post


#response.response_headers  <--is a faraday method

  def test_does_the_word_search_work

end
