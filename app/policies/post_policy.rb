class PostPolicy < ApplicationPolicy
  def update?
    author_or_admin?
  end

  def create?
    !user.nil?
  end

  def destroy?
    author_or_admin?
  end

  def pin?
    !user.nil? && user.admin?
  end
end
