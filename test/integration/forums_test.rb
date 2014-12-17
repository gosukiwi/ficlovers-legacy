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

  test 'pinned posts come first' do
    post = FactoryGirl.create(:post)
    forum = post.forum
    newer_post = FactoryGirl.create(:post, forum: forum)

    visit forum_url(forum)
    assert_equal newer_post.title, all('.posts-table tbody tr').first.all('a').first.text

    # Now that the old post is pinned, it must appear first
    post.pin
    visit forum_url(forum)
    assert_equal post.title, all('.posts-table tbody tr').first.all('a').first.text
  end
end
