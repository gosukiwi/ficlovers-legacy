class HasFollowersTest < ActiveSupport::TestCase
  def setup
    @user = FactoryGirl.create :user
  end

  test 'can follow' do
    cool_user = FactoryGirl.create :user
    @user.follow cool_user

    assert @user.following.include? cool_user
    assert cool_user.followers.include? @user
  end
end
