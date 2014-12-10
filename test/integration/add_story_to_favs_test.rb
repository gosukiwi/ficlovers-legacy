require 'test_helper'

class AddStoryToFavsTest < ActionDispatch::IntegrationTest
  test 'logged user should be able to add a fav' do
    story = FactoryGirl.create(:story)
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
