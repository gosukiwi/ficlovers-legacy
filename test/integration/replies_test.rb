require 'test_helper'

class RepliesTest < ActionDispatch::IntegrationTest
  test 'logged user can create new reply' do
    post = FactoryGirl.create(:post)
    user = FactoryGirl.create(:user) # another user, not the author

    login_as user
    visit forum_post_url(post.forum, post)
    
    assert_equal forum_post_path(post.forum, post), current_path

    fill_in 'reply_content', with: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc eu porta dolor, vel elementum libero. Cras viverra massa justo'
    click_on 'Reply'

    latest = Reply.all.last
    assert_not nil, all('.reply .stack.content').find { |reply| reply.text.include?(latest.content) }
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
end
