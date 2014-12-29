class NotificationsController < ApplicationController
  def index
    authorize Notification
    @notifications = policy_scope(Notification).paginate(page: params[:page], per_page: 25)
  end

  def destroy
    @notification = Notification.find(params[:id])
    authorize @notification
    @notification.destroy
  end
end
