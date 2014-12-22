require 'test_helper'

class RepliesTest < ActionDispatch::IntegrationTest
  test 'logged user can create new reply' do
    post = FactoryGirl.create(:post)
    user = FactoryGirl.create(:user) # another user, not the author

    assert_equal 0, post.replies.count

    login_as user
    visit forum_post_url(post.forum, post)
    
    assert_equal forum_post_path(post.forum, post), current_path

    fill_in 'reply_content', with: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc eu porta dolor, vel elementum libero. Cras viverra massa justo'
    click_on 'Reply'

    latest = Reply.all.last
    assert_equal latest.content, find(".reply.id-#{latest.id} .reply-text").text
  end

  test 'invalid replies do not get added' do
    post = FactoryGirl.create(:post)
    user = FactoryGirl.create(:user) # another user, not the author

    login_as user
    visit forum_post_url(post.forum, post)
    
    assert_equal forum_post_path(post.forum, post), current_path

    replies =  all('.reply .stack.content').count

    fill_in 'reply_content', with: 'too short'
    click_on 'Reply'

    assert_equal replies, all('.reply .stack.content').count
    assert find('.alert h3').text.include?('error')
  end

  test 'not logged user cannot reply' do
    post = FactoryGirl.create(:post)

    visit forum_post_url(post.forum, post)
    
    assert_equal forum_post_path(post.forum, post), current_path
    assert has_no_selector?('.new-reply')
  end

  test 'replies are shown' do
    reply = FactoryGirl.create(:reply)
    post = reply.post
    
    visit forum_post_url(post.forum, post)

    assert_equal post.title, find('.post-title').text
    assert_equal reply.user.username, find(".reply.id-#{reply.id} .stack.author a:first-child").text
    assert_equal reply.content, find(".reply.id-#{reply.id} .reply-text").text
  end

  test 'author can edit reply' do
    reply = FactoryGirl.create(:reply)
    post = reply.post
    user = reply.user

    login_as user
    visit forum_post_url(post.forum, post)

    # Click on btn-edit
    find(".reply.id-#{reply.id} .btn-edit").click

    other_content = reply.content + ' and some more.'
    fill_in 'reply_content', with: other_content
    click_on 'Edit reply'

    assert_equal other_content, reply.reload.content
  end

  test 'non author cannot see edit link' do
    reply = FactoryGirl.create(:reply)
    post = reply.post
    user = FactoryGirl.create(:user) # another user

    login_as user
    visit forum_post_url(post.forum, post)

    assert has_no_selector?(".reply.id-#{reply.id} .btn-edit")
  end
end
