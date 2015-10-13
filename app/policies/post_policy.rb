class PostPolicy < ApplicationPolicy
  def update?
    author_or_admin? && forum_open
  end

  def create?
    !user.nil? && forum_open
  end

  def destroy?
    author_or_admin? && forum_open
  end

  def pin?
    !user.nil? && user.admin?
  end

  def watch?
    not user.nil?
  end

private

  def forum_open
    record.forum.open? || user.admin?
  end
end
