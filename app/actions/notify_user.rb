class NotifyUser
  def initialize(user, message)
    @user = user
    @message = message
  end

  def notify
    Notification.create(user: @user, message: @message)
  end
end
