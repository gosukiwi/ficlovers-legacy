class ChapterPolicy < ApplicationPolicy
  def update?
    user.admin? || record.story.user == user
  end

  def create?
    user.admin? || record.story.user == user
  end

  def destroy?
    user.admin? || record.story.user == user
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
