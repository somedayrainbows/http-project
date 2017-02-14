
# listens on port 9292
# responds to HTTP requests
# responds with a valid HTML response that displays the words Hello, World! (0) where the 0 increments each request until the server is restarted
#######################################
require 'pry'
require 'socket'

class HTTP_yeah
  attr_reader :tcp_server
  attr_accessor :counter

  def initialize
    @tcp_server = TCPServer.new(9292)
    @counter = 0
  end

  def handle_connection
    while client = @tcp_server.accept

      puts "Ready for a request"
      request_lines = []
      while line = client.gets and !line.chomp.empty?
        request_lines << line.chomp
      end

      puts "Got this request:"
      puts request_lines.inspect

      puts "Sending response."
        if request_lines[0] == "GET /favicon.ico HTTP/1.1"
          client.puts["http/1.1 404 not-found"]
          next
        end
      response = "<pre>" + "Hello, World! (#{counter})" + "</pre>"
      output = "<html><head></head><body>#{response}</body></html>"
      headers = ["http/1.1 200 ok",
                "date: #{Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')}",
                "server: ruby",
                "content-type: text/html; charset=iso-8859-1",
                "content-length: #{output.length}\r\n\r\n"].join("\r\n")
      client.puts headers
      client.puts output

      @counter += 1

      puts ["Wrote this response:", headers, output].join("\n")
      client.close
      puts "\nResponse complete, exiting."
    end

  end
end

http = HTTP_yeah.new
http.handle_connection
