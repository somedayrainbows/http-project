require 'pry'
require 'socket'

server = TCPServer.new('localhost', 9292)

socket_should_close = false

counter = 0
counter_requests = 0

loop do
  break if socket_should_close == true
  socket = server.accept
  request = socket.gets
  STDERR.puts request
    if request == "GET / HTTP/1.1\r\n"
      counter_requests += 1
      response = "<pre>" + "GET / HTTP/1.1" +
                  "Host: localhost:9292" +
                  "User-Agent: curl/7.51.0" +
                  "Accept: */*" + "</pre>"
    elsif request == "GET /hello HTTP/1.1\r\n"
      counter_requests += 1
      response = "Hello World! (#{counter})\n"
      counter += 1
    elsif request == "GET /datetime HTTP/1.1\r\n"
      counter_requests += 1
      response = Time.now.strftime("%H:%M%p on %A, %B %-d, %Y")
    elsif request == "GET /shutdown HTTP/1.1\r\n"
      counter_requests += 1
      response = "Total Requests: #{counter_requests}"
      socket_should_close = true
    else
      counter_requests += 1
      response = "<pre>" + "GET / HTTP/1.1" +
                  "Host: localhost:9292" +
                  "User-Agent: curl/7.51.0" +
                  "Accept: */*" + "</pre>"
    end

  socket.print "HTTP/1.1 200 OK\r\n" +
               "Content-Type: text/plain\r\n" +
               "Content-Length: #{response.bytesize}\r\n" +
               "Connection: close\r\n"
  socket.print "\r\n"
  socket.print response
  socket.close
end



# "Hello World! (#{counter})\n"
