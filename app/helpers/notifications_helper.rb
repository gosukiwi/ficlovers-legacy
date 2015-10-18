module NotificationsHelper
  # If the notification has a target, display a link
  def notification_link_to(notification)
    return notification.message if notification.notificable.nil?

    case notification.notificable
    when Post
      link_for_post(notification)
    else
      link_to notification.message, notification.notificable
    end
  end

private

  def link_for_post(notification)
    post = notification.notificable
    link_to notification.message, [post.forum, post]
  end
end
