require 'test_helper'

class NotificationsTest < ActionDispatch::IntegrationTest
  test 'user can see notifications' do
    notification = FactoryGirl.create(:notification)

    login_as notification.user
    visit notifications_url

    assert notifications_path, current_path
    assert_equal notification.message, find(".notification-message").text
  end

  test 'cannot see other users notification' do
    notification = FactoryGirl.create(:notification)
    other = FactoryGirl.create(:notification, message: "Different message")

    login_as notification.user
    visit notifications_url

    assert notifications_path, current_path
    assert_not_equal other.message, find(".notification-message").text
    assert_equal 1, all(".notification-message").count
  end

  test 'must be logged in' do
    visit notifications_url
    assert login_path, current_path
  end
end
