require 'test_helper'

class PostsTest < ActionDispatch::IntegrationTest
  test 'logged user can create new post' do
    user = FactoryGirl.create(:user)
    forum = FactoryGirl.create(:forum)

    login_as user
    visit new_forum_post_url(forum)
    
    assert_equal new_forum_post_path(forum), current_path

    fill_in 'Title', with: 'This is an example post'
    fill_in 'Content', with: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.'
    click_on 'Create post'

    latest = Post.all.last
    assert_equal forum_post_path(forum, latest), current_path
    assert_equal latest.title, find('.post-title').text
  end

  test 'must be logged in to create new post' do
    forum = FactoryGirl.create(:forum)
    visit new_forum_post_url(forum)
    assert_equal login_path, current_path
  end

  test 'admin can edit other users posts' do
    post = FactoryGirl.create(:post)
    forum = post.forum
    admin = FactoryGirl.create(:user_admin)
    login_as admin

    visit edit_forum_post_url(forum, post)

    assert_equal edit_forum_post_path(forum, post), current_path
  end

  test 'cannot edit other people posts' do
    post = FactoryGirl.create(:post)
    forum = post.forum
    user = FactoryGirl.create(:user)
    login_as user

    visit edit_forum_post_url(forum, post)

    assert_equal login_path, current_path
  end

  test 'author can edit post' do
    # Given
    post = FactoryGirl.create(:post)
    forum = post.forum
    user = post.user
    login_as user

    # When
    visit edit_forum_post_url(forum, post)

    # Then
    other_content = post.content + ' and some more'

    fill_in 'Title', with: 'This is another title'
    fill_in 'Content', with: other_content
    click_on 'Edit post'

    post.reload
    assert_equal 'This is another title', post.title
    assert_equal other_content, post.content
  end

  test 'invalid posts will not be created' do
    user = FactoryGirl.create(:user)
    forum = FactoryGirl.create(:forum)

    login_as user
    visit new_forum_post_url(forum)
    
    assert_equal new_forum_post_path(forum), current_path

    click_on 'Create post'

    assert find('.alert h3').text.include?('error')
  end
end
