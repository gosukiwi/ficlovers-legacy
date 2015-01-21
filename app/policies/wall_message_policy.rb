class WallMessagePolicy < ApplicationPolicy
  def create?
    not user.nil?
  end
end
