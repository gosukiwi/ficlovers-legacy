require 'test_helper'

class ReplyTest < ActiveSupport::TestCase
  should validate_presence_of :content
  should ensure_length_of(:title).is_at_least(50)

  should belong_to :user
  should belong_to :post
end
