class PrivateMessagePolicy < ApplicationPolicy
  def index?
    not user.nil?
  end

  def create?
    not user.nil?
  end

  def destroy?
    sender_or_receiver?
  end

  def show?
    sender_or_receiver?
  end

private
  
  def sender_or_receiver?
    return false if user.nil?
    record.receiver == user || record.author == user
  end
end
