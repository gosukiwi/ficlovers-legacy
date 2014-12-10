class Admin::TagPolicy < ApplicationPolicy
  def initialize(user, record)
    raise Pundit::NotAuthorizedError, "must be logged in" unless user
    super
  end

  def index?
    user.admin?
  end

  def approve?
    user.admin?
  end

  def deny?
    user.admin?
  end
end
