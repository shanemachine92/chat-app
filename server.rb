require 'socket'
require 'time'

server = TCPServer.new(3333)
loop do
  Thread.start(server.accept) do |client|
    #accepts an incoming connection and returns a new TCPSocket object
    client.puts "The connection is in place"
    client.puts "The time is #{Time.now}"
    client.puts "The connections is now closed. Thanks for visiting!"
    client.close
  end
end
