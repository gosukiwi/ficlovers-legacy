class NotificationPolicy < ApplicationPolicy
  def index?
    not user.nil?
  end

  def destroy?
    # more like recepient or admin
    author_or_admin?
  end

  class Scope < Scope
    def resolve
      scope.where(user: user)
    end
  end
end
