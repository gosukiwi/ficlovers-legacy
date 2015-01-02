class HasThumbnailTest < ActiveSupport::TestCase
  def setup
    @story = FactoryGirl.create :story
  end

  test 'service is initiated' do
    assert_not_nil @story.persistance_service
  end

  test 'set thumb' do
    @story.expects(:upload).with('some-file').returns('some-path')
    result = @story.set_thumb 'some-file'
    assert_equal @story.thumb_url, 'some-path'
  end

  test 'set thumb and save' do
    @story.expects(:upload).with('some-file').returns('some-path')
    @story.set_thumb! 'some-file'

    other = Story.find @story.id
    assert_equal other.thumb_url, 'some-path'
  end

  test 'has thumb' do
    @story.thumb_url = 'something-not-nil'
    assert @story.has_thumb?
  end
end
