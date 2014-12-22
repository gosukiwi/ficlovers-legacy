class NotificationPolicy < ApplicationPolicy
  def index?
    not user.nil?
  end

  class Scope < Scope
    def resolve
      scope.where(user: user)
    end
  end
end
