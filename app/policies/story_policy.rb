class StoryPolicy < ApplicationPolicy
  def create?
    user != nil
  end

  def show?
    user.admin? || record.published || !record.published && record.user = user
  end

  def write?
    user.admin? || record.user == user
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
