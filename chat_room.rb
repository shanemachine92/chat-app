class ChatRoom
  attr_accessor :name, :members

  def initialize(name)
    @name = name
    @members = []
  end
end
