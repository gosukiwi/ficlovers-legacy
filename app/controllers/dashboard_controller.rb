class DashboardController < ApplicationController
  def index
    @user = current_user
    @notifications = policy_scope(Notification)
  end
end
