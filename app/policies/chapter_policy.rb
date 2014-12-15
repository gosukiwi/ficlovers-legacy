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

  protected

    # Override ApplicationPolicy's helper method
    def author_or_admin?
      return false if user.nil?
      user.admin? || record.story.user == user
    end
end
