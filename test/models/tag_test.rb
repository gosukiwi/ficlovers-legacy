require 'test_helper'

class TagTest < ActiveSupport::TestCase
  should validate_presence_of :name
  
  should validate_presence_of :context
  should validate_inclusion_of(:context).in_array(['characters', 'fandoms'])
  should validate_inclusion_of(:status).in_array(['pending', 'active', 'removed'])
end
