
require 'pry'
class Path
  attr_reader :counter_requests, :counter, :socket_should_close

  def initialize
    @counter_requests = 0
    @counter = 0
    @socket_should_close = false
  end

  def determine_response(request)
    if request == "GET / HTTP/1.1\r\n"
      response = handle_root #same as path.handle_root
    elsif request == "GET /hello HTTP/1.1\r\n"
      response = handle_hello_counter
    elsif request == "GET /datetime HTTP/1.1\r\n"
      response = handle_datetime
    elsif request == "GET /shutdown HTTP/1.1\r\n"
      response = handle_shutdown
    elsif request.split("?")[0] == "GET /word_search"
      finding_word = request.split[1]
      word_i_want = finding_word.partition("=").last
      dictionary = []
      File.open("/usr/share/dict/words") do |file|
        file.each do |line|
          dictionary << line.strip
          end
        end
        if dictionary.include?(word_i_want)
          response = "#{word_i_want.capitalize} is a known word"
        else
          response = "#{word_i_want.capitalize} is not a known word"
        end
      @counter_requests += 1
    else
      @counter_requests += 1
      response = "Sorry, you broke the internet!"
    end
    response
  end

  def handle_root #can refactor the others like this
    @counter_requests += 1
    "<pre>" + "GET / HTTP/1.1" +
    "Host: localhost:9292" +
    "User-Agent: curl/7.51.0" +
    "Accept: */*" + "</pre>"
  end

  def handle_hello_counter
    @counter_requests += 1
    @counter += 1
    "Hello World! (#{counter})\n"
  end

  def handle_datetime
    @counter_requests += 1
    Time.now.strftime("%H:%M%p on %A, %B %-d, %Y")
  end

  def handle_shutdown
    @counter_requests += 1
    @socket_should_close = true
    "Total Requests: #{counter_requests}"
  end

end
