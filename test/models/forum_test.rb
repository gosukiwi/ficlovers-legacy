require 'test_helper'

class ForumTest < ActiveSupport::TestCase
  should validate_presence_of :name
  should ensure_length_of(:name).is_at_least(3).is_at_most(50)

  #should have_many :posts
end
