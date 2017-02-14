require 'socket'

server = TCPServer.new('localhost', 9292)

counter = 0

loop do
  socket = server.accept
  request = socket.gets
  STDERR.puts request
  response = "Hello World! (#{counter})\n"
  socket.print "HTTP/1.1 200 OK\r\n" +
               "Content-Type: text/plain\r\n" +
               "Content-Length: #{response.bytesize}\r\n" +
               "Connection: close\r\n"
  socket.print "\r\n"
  socket.print response
  socket.close
  counter += 1
end
