require 'test_helper'

class TagTest < ActiveSupport::TestCase
  should validate_presence_of :name
  
  should validate_presence_of :context
  should ensure_length_of(:context).is_at_most(15)
  should validate_inclusion_of(:context).in_array([:characters, :fandoms])
end
