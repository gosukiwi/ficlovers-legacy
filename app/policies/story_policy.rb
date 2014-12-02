class StoryPolicy < ApplicationPolicy
  def write?
    user.admin? || record.user == user
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
