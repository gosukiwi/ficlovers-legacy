class NotificationsController < ApplicationController
  def index
    authorize Notification
    @notifications = policy_scope Notification
  end

  def destroy
    @notification = Notification.find(params[:id])
    authorize @notification
    @notification.destroy
  end
end
