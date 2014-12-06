require 'test_helper'

class StoryShowTest < ActionDispatch::IntegrationTest
  test 'stories should increase view count' do
    story = FactoryGirl.create(:story)
    assert_equal 0, story.views
    
    visit story_url(story)
    assert_equal story_path(story), current_path

    assert_equal 1, story.reload.views
  end
end
