class StoryPolicy < ApplicationPolicy
  def create?
    !user.nil?
  end

  def add_to_fav?
    !user.nil?
  end

  def write?
    author_or_admin?
  end

  def show?
    record.published? || author_or_admin?
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
