require 'test_helper'

class ReplyTest < ActiveSupport::TestCase
  should validate_presence_of(:content)
  should ensure_length_of(:content).is_at_least(50)

  should belong_to :user
  should belong_to :post

  test 'should increment users post_count' do
    reply = FactoryGirl.create(:reply)
    user = reply.user
    count = user.post_count

    new_reply = Reply.create(content: 'Some long content, must be at least 50 characters, content content content content', user: user)
    assert new_reply.valid?
    assert_equal reply.user, new_reply.user
    assert_equal count + 1, user.reload.post_count
  end
end
