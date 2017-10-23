require_relative './chat_server'
require 'redis'

connection = Redis.new
chat = ChatServer.new(3333, connection).run
