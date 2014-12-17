require 'test_helper'

class PostTest < ActiveSupport::TestCase
  should validate_presence_of :title
  should ensure_length_of(:title).is_at_least(5).is_at_most(100)

  should validate_presence_of :content
  should ensure_length_of(:content).is_at_least(50)

  should belong_to :user
  should belong_to :forum
  should have_one :story

  test 'should increment users post_count' do
    post = FactoryGirl.create(:post)
    user = post.user
    count = user.post_count

    new_post = Post.create(title: 'Test post', content: 'Some long content, must be at least 50 characters, content content content content', user: user)
    assert new_post.valid?
    assert_equal post.user, new_post.user
    assert_equal count + 1, user.reload.post_count
  end

  test 'post pinning' do
    post = FactoryGirl.create(:post)
    assert_not post.pinned?

    post.pin
    assert post.pinned?

    post.unpin
    assert_not post.pinned?
  end
end
