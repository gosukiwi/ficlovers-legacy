require 'test_helper'

class ChapterTest < ActiveSupport::TestCase
  should validate_presence_of :content
  should ensure_length_of(:title).is_at_least(5).is_at_most(100)

  should validate_presence_of :content
  should ensure_length_of(:content).is_at_least(150)
end
