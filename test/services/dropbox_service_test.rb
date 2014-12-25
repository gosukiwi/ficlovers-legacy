class DropboxServiceTest < ActiveSupport::TestCase
  def setup
    @service = DropboxService.new
  end

  test 'initialize' do
    assert_not_nil @service.client
  end

  test 'put file' do
    @service.client.expects(:put_file).with('name', 'content', true)
    @service.put_file 'name', 'content', true
  end

  test 'get file' do
    @service.client.expects(:media).with('some-path').returns('http://some-url')
    assert_equal 'http://some-url', @service.get_temp_file_url('some-path')
  end
end
