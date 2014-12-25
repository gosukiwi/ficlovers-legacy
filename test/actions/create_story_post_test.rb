class CreateStoryPostTest < ActiveSupport::TestCase
  def setup
    @story = FactoryGirl.create :story
    @action = CreateStoryPost.new @story
  end

  test 'with existing post' do
    assert_nil @action.run
  end

  test 'with non-existant post' do
    @story.post = nil
    @action.run
    assert_not_nil @story.post
  end

  test 'created post is valid' do
    @story.post = nil
    @action.run

    post = @story.post

    assert_equal @story.title, post.title
    assert_equal @story.user, post.user
  end
end
