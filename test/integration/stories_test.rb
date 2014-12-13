require 'test_helper'

class StoryShowTest < ActionDispatch::IntegrationTest
  test 'search should be paginated, 10 per page' do
    # todo
  end

  test 'fresh stories should be paginated, 10 per page' do
    visit fresh_stories_url

    assert_equal fresh_stories_path, current_path
    assert_not has_selector?('.pagination')

    11.times { FactoryGirl.create(:story_published) }
    visit fresh_stories_url

    assert_equal fresh_stories_path, current_path
    assert has_selector?('.pagination')
    assert_equal 10, all('.fic').count
  end

  test 'fresh stories should be the latest' do
    FactoryGirl.create(:story_published)
    newest = FactoryGirl.create(:story_published)
    
    visit fresh_stories_url

    assert_equal fresh_stories_path, current_path
    # assert that the first story is the newest
    assert all('.fic').first.text.include?(newest.title)
  end

  test 'stories should increase view count' do
    story = FactoryGirl.create(:story_published)
    assert_equal 0, story.views
    
    visit story_url(story)

    assert_equal story_path(story), current_path
    assert_equal 1, story.reload.views
  end

  test 'logged user should be able to add a fav' do
    story = FactoryGirl.create(:story_published)
    user = FactoryGirl.create(:user)

    assert_equal 0, story.favs.count

    login_as user

    visit story_url(story)
    click_on 'Add to favs'

    assert_equal 1, story.reload.favs.count
  end

  test 'logged user cannot fav his own fics' do
    story = FactoryGirl.create(:story)
    author = story.user

    assert_equal 0, story.favs.count

    login_as author

    visit story_url(story)
    click_on 'Add to favs'

    assert_equal 0, story.reload.favs.count
  end

  test 'not logged user does not see fav link' do
    story = FactoryGirl.create(:story)

    assert_equal 0, story.favs.count

    visit story_url(story)
    assert has_no_selector?("//#fav-status")
  end
end
