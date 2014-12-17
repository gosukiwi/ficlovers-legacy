class ReplyPolicy < ApplicationPolicy
  def create?
    !user.nil?
  end

  def update?
    author_or_admin?
  end

  def destroy?
    author_or_admin?
  end
end
