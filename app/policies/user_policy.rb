class UserPolicy < ApplicationPolicy
  def update?
    user.admin? || record == user
  end

  def create?
    true
  end

  def destroy?
    # Only admins can delete, and they cannot delete themselves!
    user.admin? && record != user
  end

  class Scope < Scope
    def resolve
      if user.admin?
        scope.all
      else
        scope.where(id: user.id)
      end
    end
  end
end
