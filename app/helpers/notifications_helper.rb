module NotificationsHelper
  def notify_user(user, message: message, action: action) 
    Notification.create message: message, action: action, user: user, read: false
  end
end
