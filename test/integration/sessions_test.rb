require 'test_helper'

class StoriesTest < ActionDispatch::IntegrationTest
  test 'login with username' do
    user = FactoryGirl.create(:user)

    visit login_url
    fill_in 'Username', with: user.username
    fill_in 'Password', with: user.password
    find('input[type=submit]').click

    assert_not_equal login_path, current_path
  end
end
