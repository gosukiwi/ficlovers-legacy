class NotificationsController < ApplicationController
  before_action :set_notification, only: [:destroy]
  def index
    authorize Notification
    @notifications = scope.sorted.paginate(page: params[:page], per_page: 25)
  end

  def destroy
    authorize @notification
    @notification.destroy
  end

  def destroy_all
    scope.delete_all
  end

  private

  def scope
    policy_scope(Notification)
  end

  def set_notification
    @notification = Notification.find(params[:id])
  end
end
