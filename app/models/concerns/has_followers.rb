module HasFollowers
  extend ActiveSupport::Concern

  included do
    has_and_belongs_to_many :followers, association_foreign_key: :followee_id, foreign_key: :follower_id, join_table: :followers, class_name: 'User'
    has_and_belongs_to_many :following, association_foreign_key: :follower_id,  foreign_key: :followee_id, join_table: :followers, class_name: 'User'
  end
  
  def follow_toggle(user)
    if following.include? user
      unfollow user
    else
      follow user
    end
  end

  def follow(user)
    return false if user == self
    following << user
    save
  end

  def unfollow(user)
    !!following.delete(user)
  end
end
