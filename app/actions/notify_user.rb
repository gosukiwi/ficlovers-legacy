class NotifyUser
  attr_reader :user, :message, :target
  def initialize(user, message, target = nil)
    @user = user
    @message = message
    @target ||= { type: target.class, id: target.id }
  end

  def notify
    if target.nil?
      Notification.create(user: user, message: message)
    else
      Notification.create(user: user, message: message, target_type: target[:type], target_id: target[:id])
    end
  end
end
