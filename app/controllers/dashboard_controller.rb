class DashboardController < ApplicationController
  before_action :set_user, only: [:index]

  def index
    @notifications = policy_scope(Notification).sorted.limit(5)
    @feed = @user.feed.limit(2)
  end

protected

  def set_user
    @user = current_user
  end
end
