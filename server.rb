require 'socket'

class ChatServer

  def initialize(port)
    @activeSockets = []
    @server = TCPServer.new("", port)
    @server.setsockopt(Socket::SOL_SOCKET, Socket::SO_REUSEADDR, 1)
    # To reuse the address (for rapid restarts of the server), 
    #you enable the SO_REUSEADDR socket option.
    puts "Chat server started on port: #{port}"
    @activeSockets.push(@server)
  end

  def run
    while 1
      res = select(@activeSockets, nil, nil, nil)
      if res !=nil
        for socket in res[0]
          if socket == @server
            accept_new_connection
          else
            if socket.eof?
              # Returns true if ios is at end of file that means there are no more data to read. 
              # The stream must be opened for reading or an IOError will be raised
              #  in other words, you check whether the client has disconnected. 
              str = "Client left #{socket.peeraddr[2]}:#{socket.peeraddr[1]}\n"
              broadcast_string(str, socket)
              socket.close
              @activeSockets.delete(socket)
            else
              str = "[#{socket.peeraddr[2]}|#{socket.peeraddr[1]}]: #{socket.gets()}"
              broadcast_string(str, socket)
            end
          end
        end
      end
    end
  end

  private

  def broadcast_string(str, omit_socket)
    @activeSockets.each do |clientSocket|
      if clientSocket != @server && clientSocket != omit_socket
        clientSocket.write(str)
      end
    end
    print(str)
  end

  def accept_new_connection
    newSocket = @server.accept
    @activeSockets.push(newSocket)

    newSocket.write("You're connective to Shane's Chat App Server\n")

    str = "Client joined #{newSocket.peeraddr[2]}:#{newSocket.peeraddr[1]}\n"

    broadcast_string(str, newSocket)
  end
end

myChat = ChatServer.new(3333).run
