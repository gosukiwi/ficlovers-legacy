class StoryFeed
  attr_reader :user
  def initialize(user)
    @user = user
  end

  def generate
    Story.where(user: followers).order(updated_at: :desc)
  end

private

  def followers
    user.followers
  end
end
