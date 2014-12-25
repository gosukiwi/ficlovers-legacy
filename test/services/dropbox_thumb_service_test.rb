class DropboxThumbServiceTest < ActiveSupport::TestCase
  test 'get empty thumb' do
    story = stub(has_thumb?: false)
    service = DropboxThumbService.new story
    assert_nil service.get_thumb
  end

  test 'get non-expired thumb' do
    story = stub(has_thumb?: true, expired?: false, thumb_temp_url: 'an-url')
    service = DropboxThumbService.new story
    assert_equal 'an-url', service.get_thumb
  end

  test 'get expired thumb and refresh' do
    story = stub(has_thumb?: true, expired?: true, thumb_temp_url: 'an-url')
    service = DropboxThumbService.new story
    service.expects(:refresh)
    assert_equal 'an-url', service.get_thumb
  end

  test 'set thumb' do
    story = mock()
    story.expects(:thumb_path=).with('/a-path')

    service = DropboxThumbService.new story
    service.stubs(:save_file).with('the-file').returns({'path' => '/a-path'})
    service.stubs(:refresh)

    # story expects thumb_path= to be called with '/a-path'
    service.set_thumb 'the-file'
  end

  test 'save file' do
    story = stub(id: 5)
    service = DropboxThumbService.new story

    # test for call and correct path format
    service.instance_variable_get(:@dropbox)
      .expects(:put_file)
      .with('/5_thumb.jpg', 'contents', true)

    file_data = stub original_filename: 'somefile.jpg', read: 'contents'
    service.send :save_file, file_data
  end

  test 'refresh' do
    # the path the item already has saved in the local db
    saved_path = '/a-path'
    # file data returned from dropbox
    dbx_file_data = {'url' => 'an-url', 'expires' => DateTime.now.to_s}

    # Make sure the attributes are beeing set and it gets saved
    story = mock(thumb_path: saved_path)
    story.expects(:thumb_temp_url=).with(dbx_file_data['url'])
    story.expects(:thumb_expiration=).with(dbx_file_data['expires'])
    story.expects(:save)

    service = DropboxThumbService.new story

    # test for call and correct path format
    service.instance_variable_get(:@dropbox)
      .expects(:get_temp_file_url)
      .with(saved_path)
      .returns(dbx_file_data)

    service.send :refresh
  end
end
