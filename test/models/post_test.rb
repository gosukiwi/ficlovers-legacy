require 'test_helper'

class PostTest < ActiveSupport::TestCase
  should validate_presence_of :title
  should ensure_length_of(:title).is_at_least(5).is_at_most(100)

  should validate_presence_of :content
  should ensure_length_of(:title).is_at_least(50)

  should belong_to :user
  should belong_to :forum
end
