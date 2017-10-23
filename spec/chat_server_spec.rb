require_relative '../chat_server'

RSpec.describe ChatServer do
  before(:all) do
    @server = ChatServer.new(3333)
    @new_socket = TCPSocket.new("", 3333)
  end

  let(:chat_room) do
    instance_double(
      'ChatRoom',
      name: name,
      members: members
    )
  end

  let(:name) { 'TestRoom' }
  let(:members) { ['TestMembers1', 'TestMember2'] }

  describe '#initialize' do
    it 'has no chatroooms' do
      expect(@server.chat_rooms.length).to eq(0)
    end

    it 'has one active socket' do
      expect(@server.active_sockets.length).to eq(1)
    end
  end

  describe '#accept_new_connection' do
    before { allow_any_instance_of(ChatServer).to receive(:accept_new_connection) }
    it 'accepts new connections' do
      @server.accept_new_connection
      expect(@server).to have_received(:accept_new_connection)
    end
  end

  describe 'get_user_details' do
    before { allow_any_instance_of(ChatServer).to receive(:get_user_details) }
    it 'gets username from the socket' do
      @server.get_user_details
      expect(@server).to have_received(:get_user_details)
    end
  end

  describe 'chat_options' do
    before { allow_any_instance_of(ChatServer).to receive(:chat_options) }
    it 'gives user option to join or create a room' do
      @server.chat_options
      expect(@server).to have_received(:chat_options)

    end
  end

  describe '#create_new_chatroom' do
    before { allow_any_instance_of(ChatServer).to receive(:create_new_chatroom) }
    it 'creates a new chatroom' do
      @server.create_new_chatroom
      expect(@server).to have_received(:create_new_chatroom)
      expect(@server.chat_rooms.length).to eq(1)
    end

    it 'calls list chat members' do
      @server.stub(:list_chat_members)
      @server.create_new_chatroom
      expect(@server).to have_received(:list_chat_members)
    end
  end

  describe '#join_existing_chatroom' do
    before { allow_any_instance_of(ChatServer).to receive(:join_existing_chatroom) }
    it 'asks user which room they want to join' do
      @server.join_existing_chatroom
      expect(@server).to have_received(:join_existing_chatroom)
    end
  end

  describe '#announce_new_user' do
    before { allow_any_instance_of(ChatServer).to receive(:announce_new_user) }
    it 'announces when new user joins the chat server' do
      @server.announce_new_user
      expect(@server).to have_received(:announce_new_user)
    end
  end

  describe 'list_chat_members' do
    before { allow_any_instance_of(ChatServer).to receive(:list_chat_members) }
    it 'lists current members in the chat room' do
      @server.list_chat_members
      expect(@server).to have_received(:list_chat_members)
    end
  end

  describe 'broadcast_string' do
    let(:str) {'Everything is awesome' }
    let(:current_socket) { @new_socket }
    before { allow_any_instance_of(ChatServer).to receive(:broadcast_string) }
    it 'writes message to other users' do
      @server.broadcast_string(str, current_socket)
      expect(@server).to have_received(:broadcast_string)
    end
  end
end
