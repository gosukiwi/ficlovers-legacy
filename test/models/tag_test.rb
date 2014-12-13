require 'test_helper'

class TagTest < ActiveSupport::TestCase
  should validate_presence_of :name
  should validate_presence_of :context
  should validate_inclusion_of(:context).in_array(['characters', 'fandoms', 'genres', 'pending'])
  should validate_inclusion_of(:status).in_array(['pending', 'active', 'removed'])

  test 'should override to_s' do
    tag = FactoryGirl.create(:tag)
    assert_equal "#{tag.name} (#{tag.context})", tag.to_s
  end


  test 'search should work for active tags' do
    tag = FactoryGirl.create(:tag_active)
    search_result = Tag.search(tag.name[0, 4])
    assert_equal tag, search_result.first
  end

  test 'search should avoid non-active tags' do
    tag = FactoryGirl.create(:tag)
    search_result = Tag.search(tag.name[0, 4])
    assert_equal 0, search_result.count
  end

  test 'context default value must be "pending"' do
    tag = Tag.new name: 'Haruno Sakura'
    assert_equal 'pending', tag.context
  end

  test 'should not be able to be active and pending in context' do
    tag = Tag.new name: 'Haruno Sakura'
    tag.status = 'active'
    assert_raise RuntimeError do
      tag.save
    end
  end
end
