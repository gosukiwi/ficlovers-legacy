class PrivateMessageSender
  def initialize(options)
    options.receiver = fetch_receiver(options.receiver)
    @message = PrivateMessage.new(options)
  end

  def fetch_receiver(username)
    User.find_by!(username: username)
  end

  def send
    @message.save!
  end
end
