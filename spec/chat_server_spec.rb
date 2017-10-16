require_relative '../chat_server'

RSpec.describe ChatServer do
  before(:all) do
    @server = ChatServer.new(3333)
    @new_socket = TCPSocket.new
  end

  describe '#initialize' do
    it 'has no chatroooms' do
      expect(@server.chat_rooms.length).to eq(0)
    end

    it 'has one active socket' do
      expect(@server.active_sockets.length).to eq(1)
    end
  end

  describe 'accept new connection' do
    it 'accepts new connection' do
      
    end

  end

  describe 'get_user_details' do
    it 'prompts new user for their username' do
    end

    it 'welcomes them' do
    end
  end

  describe 'chat_options' do
    context 'when user chooses to create a new room' do
      it 'calls #create_new_chatroom' do
      end
    end

    context 'when user chooses to join existing room' do
      it 'calls #join_existing_chatroom' do
      end
    end

    context 'when user chooses options option' do
      it 'calls itself' do
      end
    end

    context 'when user makes an invalid selection' do
      it 'alerts user that their choice is invalid' do
      end

      it 'calls itself' do
      end
    end
  end

  describe '#create_new_chatroom' do
    it 'prompts user to name new room' do
    end

    it 'sets room name' do
    end

    it 'adds chat room to the chat rooms array' do
    end

    it 'alerts user that the room has been created' do
    end

    it 'lists the current people in the chat room' do
    end
  end

  describe '#join_existing_chatroom' do
    context 'when there are active rooms' do
      it 'lists them' do
      end
    end

    context 'when there are no active rooms' do
      it 'directs user to create a new room' do
      end
    end
  end

  describe '#announce_new_user' do
    context 'users are in the chat room where a new person has joined' do
      it 'writes to user that a new user has joined' do
      end
    end

    context 'users are not in a chat where a new person has joined' do
      it 'does not write to user that a new user has joined' do
      end
    end
  end

  describe 'list_chat_members' do
    it 'adds name of new user to current chat room members list' do
    end

    it 'lists all chat room members' do
    end
  end
end
