require 'test_helper'

class StoryTest < ActiveSupport::TestCase
  should validate_presence_of :title
  should ensure_length_of(:title).is_at_least(5).is_at_most(100)

  should validate_presence_of :summary
  should ensure_length_of(:summary).is_at_least(50).is_at_most(250)

  should belong_to :category
  should belong_to :user
  should have_many :chapters

  test 'story must delete all related chapters when deleted' do
    chapter = FactoryGirl.create(:chapter)
    story = chapter.story

    story.destroy
    assert_raise(ActiveRecord::RecordNotFound) { Chapter.find(chapter.id) }
  end

  test 'story must have a default published value of false' do
    story = FactoryGirl.create(:story)
    assert_equal false, story.published
  end

  test 'stories must have views starting at 0' do
    story = FactoryGirl.create(:story)
    assert_equal 0, story.views
  end

  test 'stories incremental function' do
    story = FactoryGirl.create(:story)
    assert_equal 0, story.views

    story.increment_views
    assert_equal 1, story.views
  end

  test 'hot stories, fav matter more than views' do
    # a popular story has more views than a common one, but favs are more
    # important
    popular = FactoryGirl.create(:story_popular)
    faved = FactoryGirl.create(:story)
    faved.add_to_fav(popular.user)

    # so now hot should have 'faved' as the first story
    hot = Story.hot
    assert_equal hot.first(), faved
  end

  test 'hot stories, if favs are even, views matter' do
    # both stories have 0 favs, so now views should matter
    popular = FactoryGirl.create(:story_popular)
    common = FactoryGirl.create(:story)

    # popular should be first
    hot = Story.hot
    assert_equal hot.first(), popular
  end

  test 'stories can be faved' do
    story = FactoryGirl.create(:story)
    user = FactoryGirl.create(:user) # a different user than the author

    story.add_to_fav user
    assert_equal 1, user.favs.count
    assert_equal story.title, user.favorites.first().title
  end
end
