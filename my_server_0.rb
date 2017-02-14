
# listens on port 9292
# responds to HTTP requests
# responds with a valid HTML response that displays the words Hello, World! (0) where the 0 increments each request until the server is restarted
#######################################
require 'pry'
require 'socket'

class HTTP_yeah
  attr_reader :tcp_server, :counter

  def initialize
    @tcp_server = TCPServer.new(9292)
    @counter = 1
  end

  def handle_connection
    while client = @tcp_server.accept
      puts "<h1>" + "Hello, World! (#{@counter})\n" + "</h1>"
      counter += 1
    end

  puts "Ready for a request"
  request_lines = []
  while line = client.gets and !line.chomp.empty?
    request_lines << line.chomp
  end

  puts "Got this request:"
  puts request_lines.inspect

  puts "Sending response."
  response = "<pre>" + request_lines.join("\n") + "</pre>"
  output = "<html><head></head><body>#{response}</body></html>"
  headers = ["http/1.1 200 ok",
            "date: #{Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')}",
            "server: ruby",
            "content-type: text/html; charset=iso-8859-1",
            "content-length: #{output.length}\r\n\r\n"].join("\r\n")
  client.puts headers
  client.puts output

  puts ["Wrote this response:", headers, output].join("\n")
  client.close
  puts "\nResponse complete, exiting."

  end
end
