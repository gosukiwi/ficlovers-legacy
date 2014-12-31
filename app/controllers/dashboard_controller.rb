class DashboardController < ApplicationController
  def index
    @user = current_user
    @notifications = policy_scope(Notification).sorted.limit(5)
  end
end
