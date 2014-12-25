require 'test_helper'

class StoryTest < ActiveSupport::TestCase
  should validate_presence_of :title
  should ensure_length_of(:title).is_at_least(5).is_at_most(100)

  should validate_presence_of :summary
  should ensure_length_of(:summary).is_at_least(50).is_at_most(250)

  should belong_to :category
  should belong_to :user
  should have_many :chapters
  should belong_to :post

  test 'searching for tags should be inclusive' do
    story = FactoryGirl.create(:story)
  end

  test 'search should return only published stories' do
    story = FactoryGirl.create(:story)
    #Story.search(category: 0, tags: story.first.name + ' (' + story.first.context + ')')
  end

  test 'should have published? method' do
    story = FactoryGirl.create(:story)
    story_p = FactoryGirl.create(:story_published)
    assert_equal false, story.published?
    assert_equal true, story_p.published?
  end

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
    faved = FactoryGirl.create(:story_published)
    faved.add_to_fav(popular.user)

    # so now hot should have 'faved' as the first story
    hot = Story.hot
    assert_equal hot.first(), faved
  end

  test 'hot stories, if favs are even, views matter' do
    # both stories have 0 favs, so now views should matter
    popular = FactoryGirl.create(:story_popular)
    common = FactoryGirl.create(:story_published)

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

  test 'story should fetch chapters ordered' do
    story = FactoryGirl.create(:story)

    chapter_1 = FactoryGirl.create(:chapter)
    chapter_1.order = 2
    story.chapters << chapter_1

    chapter_2 = FactoryGirl.create(:chapter)
    chapter_2.order = 1
    story.chapters << chapter_2

    story.save

    assert_equal 2, story.reload.chapters.count

    # Okay, test for order
    chapters = story.chapters.ordered
    assert_equal chapters.first(), chapter_2
    assert_equal chapters.last(), chapter_1
  end

  test 'should fetch active_tags' do
    story = FactoryGirl.create(:story)
    tag = FactoryGirl.create(:tag_active)

    story.tags << tag
    assert_equal tag, story.active_tags.first
  end

  test 'story must have an associated forum post when created' do
    story = FactoryGirl.create(:story)
    story.update(published: true)
    story.reload

    assert_not_nil story.post.title
  end
end
