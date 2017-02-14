require 'pry'
require 'socket'

server = TCPServer.new('localhost', 9292)

counter = 0

loop do
  socket = server.accept
  request = socket.gets
  STDERR.puts request
  if request == "GET / HTTP/1.1\r\n"
    response = "<pre>" + "GET / HTTP/1.1" +
                "Host: localhost:9292" +
                "User-Agent: curl/7.51.0" +
                "Accept: */*" + "</pre>"
  elsif request == "GET /hello HTTP/1.1\r\n"
    response = "Hello World! (#{counter})\n"
    counter += 1
  elsif request == "GET /datetime HTTP/1.1\r\n"
    response = Time.now.strftime("%H:%M%p on %A, %B %-d, %Y")
  elsif request == "GET /shutdown HTTP/1.1\r\n"
    response = "Total Requests: #{}" #number of total requests
  else
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
