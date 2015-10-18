class NotifyUser
  attr_reader :user, :message, :notificable
  def initialize(user:, message:, notificable: = nil)
    @user = user
    @message = message
    @notificable = notificable unless notificable.nil?
  end

  def notify
    if target.nil?
      Notification.create(user: user, message: message)
    else
      Notification.create(user: user, message: message, notificable: target)
    end
  end
end
