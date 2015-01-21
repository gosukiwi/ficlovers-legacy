class FollowUser
  def initialize(follower, followee)
    @follower = follower
    @followee = followee
  end

  def follow
    return false if @follower == @followee
    notify if @follower.follow_toggle @followee
  end

protected

  def notify
    message = "Congratulations! #{@follower.username} now follows you!"
    NotifyUser.new(@followee, message, @follower).notify
  end
end
