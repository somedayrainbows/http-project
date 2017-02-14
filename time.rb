require 'socket'

server = TCPServer.new('localhost', 9292)

counter = 0

loop do
  socket = server.accept
  request = socket.gets
  STDERR.puts request
  response = "<pre>" + "GET / HTTP/1.1" +
                    "Host: localhost:9292" +
                    "User-Agent: curl/7.51.0" +
                    "Accept: */*" + "</pre>"
  socket.print "HTTP/1.1 200 OK\r\n" +
               "Content-Type: text/plain\r\n" +
               "Content-Length: #{response.bytesize}\r\n" +
               "Connection: close\r\n"
  socket.print "\r\n"
  socket.print response
  socket.close
  counter += 1
end
