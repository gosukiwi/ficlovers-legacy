class CreateStoryPostTest < ActiveSupport::TestCase
  def setup
    @story = FactoryGirl.create :story
    @action = CreateStoryPost.new @story
  end

  test 'do not create with existing post' do
    assert_not_nil @story.post
    assert_nil @action.create
  end

  test 'create when there is no post' do
    @story.post = nil
    assert_not_nil @action.create
    assert_not_nil @story.post
  end

  test 'created post is valid' do
    @story.post = nil
    @action.create

    post = @story.post

    assert_equal @story.title, post.title
    assert_equal @story.user, post.user
  end
end
