class NotifyUserTest < ActiveSupport::TestCase
  test 'with valid data' do
    user = FactoryGirl.create :user
    NotifyUser.new(user, 'Hello, World!').notify
    assert_equal 'Hello, World!', user.reload.notifications.first.message
  end

  test 'with invalid data' do
    user = FactoryGirl.create :user
    NotifyUser.new(user, nil).notify
    assert_equal 0, user.reload.notifications.count
  end
end
