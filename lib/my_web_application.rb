require './lib/path'

require 'pry'

require 'socket'

server = TCPServer.new(9292)

path = Path.new #same as def initialize from other class file

loop do
  break if path.socket_should_close == true
  socket = server.accept
  request = socket.gets
  STDERR.puts request
  response = path.determine_response(request)

  socket.print "HTTP/1.1 200 OK\r\n" +
               "Content-Type: text/plain\r\n" +
               "Content-Length: #{response.bytesize}\r\n" +
               "Connection: close\r\n"
  socket.print "\r\n"
  socket.print response
  socket.close
end
