require 'test_helper'

class StoryTest < ActiveSupport::TestCase
  should validate_presence_of :title
  should ensure_length_of(:title).is_at_least(5).is_at_most(100)

  should validate_presence_of :summary
  should ensure_length_of(:summary).is_at_least(50).is_at_most(250)

  should belong_to :category
  should belong_to :user
  should have_many :chapters

  test 'chapter must be deleted after a story' do
    chapter = FactoryGirl.create(:chapter)
    story = chapter.story

    story.destroy
    assert_raise(ActiveRecord::RecordNotFound) { Chapter.find(chapter.id) }
  end
end
