# Something which users can follow
module HasFollowers
  extend ActiveSupport::Concern

  included do
    has_many :follows
    #has_many :users, through: :follows, as: :followable

    scope :followed_by, ->(user) { where(id: Follow.where(user: user, followable_type: self.name).pluck(:followable_id)) }
  end

  def followers
    @followers ||= User.where(id: user_ids)
  end

  def follow_toggle(user)
    if followers.include? user
      remove_follower user
    else
      add_follower user
    end
  end

  def add_follower(user)
    return false if user == self
    Follow.create followable: self, user: user
  end

  def remove_follower(user)
    Follow.find(followable: self, user: user).destroy!
  end

  def followed_by?(user)
    followers.include?(user)
  end

private

  def user_ids
    Follow.where(followable_id: id, followable_type: self.class.name).pluck(:user_id)
  end
end
