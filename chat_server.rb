require 'socket'
require 'pry'
require_relative './chat_room'
require_relative './client'

class ChatServer
  attr_accessor :port, :active_sockets, :chat_rooms, :server

  def initialize(port)
    @active_sockets = []
    @chat_rooms = []
    @server = TCPServer.new("", port)
    # usng "" lets you accept connections from any of the available interfaces on the host
    # available interfaces on the host
    @server.setsockopt(Socket::SOL_SOCKET, Socket::SO_REUSEADDR, 1)
    # To reuse the address (for rapid restarts of the server), 
    # you enable the SO_REUSEADDR socket option.
    puts "Chat server started on port: #{port}"
    @active_sockets << @server
  end

  def run
    loop do
      result = select(@active_sockets, nil, nil, nil)
      #read, write, exception, timeouts
      if result !=nil
        result[0].each do |socket|
          if socket == @server
            accept_new_connection
          elsif socket.eof?
              # Returns true if ios is at end of file that means there are no more data to read. 
              # The stream must be opened for reading or an IOError will be raised
              #  in other words, you check whether the client has disconnected. 
              str = "#{socket.username} left\n"
              broadcast_string(str, socket)
              socket.close
              @active_sockets.delete(socket)
          else
            str = "#{socket.username}: #{socket.gets()}"
            broadcast_string(str, socket)
          end
        end
      end
    end
  end

  def get_user_details
    @new_socket.write "Please enter a username\n"
    @new_socket.username = @new_socket.gets.chomp
    @new_socket.write "Welcome, #{@new_socket.username}!\n"
  end

  def chat_options
    @new_socket.write "Would you like to [1] create a new chat room or [2] join an existing one?\n"
    str = @new_socket.gets.chomp.to_s.downcase

    case str
    when '1'
      create_new_chatroom
      announce_new_user
    when '2'
      join_existing_chatroom
      announce_new_user
    when 'options'
      chat_options
    else
      @new_socket.write "Invalid choice.\n"
      chat_options
    end
  end

  def create_new_chatroom
    @new_socket.write "What would you like to name your new chat room?\n"
    @new_chat_room = ChatRoom.new(@new_socket.gets.chomp)
    @new_socket.current_room = @new_chat_room.name
    @chat_rooms << @new_chat_room.name
    @new_socket.write "Chat room #{@new_chat_room.name} has been created. You are now in this room.\n"
    list_chat_members
  end

  def join_existing_chatroom
    if @chat_rooms.length != 0
      @new_socket.write "Here is the list of rooms:\n #{@chat_rooms}\n"
      @new_socket.write "Which would you like to enter?\n"
      @new_socket.current_room = @new_socket.gets.chomp.downcase
      if @chat_rooms.include? @new_socket.current_room
        @new_socket.write "You are now in the #{@new_socket.current_room} chat room.\n"
        list_chat_members
      else
        @new_socket.write "That room doesn't exist.\n"
        chat_options
      end
    else
      @new_socket.write "There are currently no active rooms. Please create one!\n"
      create_new_chatroom
    end
  end

  def announce_new_user
    str = "#{@new_socket.username} joined room #{@new_socket.current_room}\n"
    broadcast_string(str, @new_socket)
  end

  def list_chat_members
    @chat_members = @new_chat_room.members << @new_socket.username
    @new_socket.write "Current members: #{@chat_members.each { |member| puts member }}\n"
  end

  private

  def broadcast_string(str, current_socket)
    @active_sockets.each do |client_socket|
      if client_socket != @server && client_socket != current_socket && client_socket.current_room == current_socket.current_room
        client_socket.write(str)
      end
    end
    puts str
  end

  def accept_new_connection
    @new_socket = @server.accept.extend Client
    @active_sockets << @new_socket
    @new_socket.write "You're connected to Shane's Chat App Server\n"
    get_user_details
    chat_options
  end
end
