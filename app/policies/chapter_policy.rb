class ChapterPolicy < ApplicationPolicy
  def update?
    author_or_admin?
  end

  def create?
    author_or_admin?
  end

  def destroy?
    author_or_admin?
  end
end
