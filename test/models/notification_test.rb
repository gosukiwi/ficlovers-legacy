require 'test_helper'

class NotificationTest < ActiveSupport::TestCase
  should validate_presence_of :message
  should belong_to :user
end
