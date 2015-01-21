module NotificationsHelper
  # If the notification has a target, display a link
  def notification_link_for(notification)
    return notification.message if notification.target_id.nil?
    link_to notification.message, notification.target_type.constantize.find(notification.target_id)
  end
end
