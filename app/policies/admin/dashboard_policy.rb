class Admin::DashboardPolicy < ApplicationPolicy
  def initialize(user, record)
    raise Pundit::NotAuthorizedError, "must be logged in" unless user
    super
  end
  def index?
    user.admin?
  end
end
