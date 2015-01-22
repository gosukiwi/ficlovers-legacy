class DashboardController < ApplicationController
  def index
    @user = current_user
    @notifications = policy_scope(Notification).sorted.limit(5)
    @feed = @user.feed.limit(2)
  end
end
