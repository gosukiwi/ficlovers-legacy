class HasThumbnailTest < ActiveSupport::TestCase
  def setup
    @story = FactoryGirl.create :story
  end

  test 'service is initiated' do
    assert_not_nil @story.thumb_persistance_service
  end

  test 'get thumb' do
    @story.thumb_persistance_service.expects(:get_thumb).returns('a-thumb-url')
    assert_equal 'a-thumb-url', @story.get_thumb
  end

  test 'set thumb' do
    @story.thumb_persistance_service.expects(:set_thumb).with('some-file')
    @story.set_thumb 'some-file'
  end

  test 'is expired' do
    @story.thumb_expiration = DateTime.now + 1.day
    assert_not @story.expired?

    @story.thumb_expiration = 1.day.ago
    assert @story.expired?
  end
end
