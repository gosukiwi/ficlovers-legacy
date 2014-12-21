require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # Email validations
  should validate_presence_of :email
  should validate_uniqueness_of :email
  should ensure_length_of(:email).is_at_most(255)
  should allow_value('mike@gmail.com').for(:email)
  should_not allow_value('mike').for(:email)
  should_not allow_value('mike@gmail').for(:email)
  should_not allow_value('gmail.com').for(:email)

  should validate_presence_of :name
  should ensure_length_of(:name).is_at_most(50).is_at_least(2)

  should validate_presence_of :username
  should validate_uniqueness_of :username
  should ensure_length_of(:username).is_at_most(25).is_at_least(3)

  should ensure_length_of(:password).is_at_least(6)

  should validate_inclusion_of(:role).in_array(['admin', 'user'])

  test "regular user should not be admin" do
    user = FactoryGirl.create(:user)
    assert_not user.admin?
  end

  test "admin should be reported as admin" do
    user = FactoryGirl.create(:user_admin)
    assert user.admin?
  end
end
