require 'socket'

hostname = '127.0.0.1'
port = 3333

a = TCPSocket.new(hostname, port)

while line = a.gets
  puts line.chop
end
a.close

