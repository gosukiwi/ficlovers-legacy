class PrivateMessagePolicy < ApplicationPolicy
  def index?
    not user.nil?
  end

  def create?
    not user.nil?
  end

  def destroy?
    record.receiver == record.author
  end

  def show?
    return false if user.nil?
    record.author == user || record.receiver == user
  end
end
