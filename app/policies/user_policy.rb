class UserPolicy < ApplicationPolicy
  def update?
    user.admin? || record == user
  end

  def create?
    true
  end

  def destroy?
    # Only admins can delete, and they cannot delete themselves!
    user.admin?
  end
end
