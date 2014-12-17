require 'test_helper'

class ForumsTest < ActionDispatch::IntegrationTest
  test 'user can see new-post button' do
    forum = FactoryGirl.create(:forum)
    user = FactoryGirl.create(:user)

    login_as user
    visit forum_url(forum)

    find('.new-post').click

    assert_equal new_forum_post_path(forum), current_path
  end

  test 'anon cannot see new-post button' do
    forum = FactoryGirl.create(:forum)
    user = FactoryGirl.create(:user)

    visit forum_url(forum)

    assert has_no_selector?('.new-post')
  end

  test 'forums posts are beeing displayed' do
    post = FactoryGirl.create(:post)

    visit forum_url(post.forum)

    assert_equal post.title, all('.posts-table a').first.text
  end
end
