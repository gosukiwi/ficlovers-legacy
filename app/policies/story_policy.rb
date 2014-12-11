class StoryPolicy < ApplicationPolicy
  def create?
    user != nil
  end

  def add_to_fav?
    user != nil
  end

  def write?
    user && user.admin? || record.user == user
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
