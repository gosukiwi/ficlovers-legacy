class UserPolicy < ApplicationPolicy
  def update?
    return false if user.nil?
    user.admin? || record == user
  end

  def about?
    update?
  end

  def create?
    true
  end

  def follow?
    not user.nil?
  end

  def fics?
    true
  end

  def favs?
    true
  end

  def feed?
    true
  end

  # Only logged in users can search for now, mostly because it's only used
  # for PM autocomplete
  def search?
    not user.nil?
  end

  # Only admins can delete, and they cannot delete themselves!
  def destroy?
    return false if user.nil?
    user.admin? && user != record
  end
end
