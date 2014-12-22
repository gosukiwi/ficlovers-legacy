class NotificationsController < ApplicationController
  def index
    authorize Notification
    @notifications = policy_scope Notification
  end
end
