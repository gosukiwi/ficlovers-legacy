class FinishThumbTest < ActiveSupport::TestCase
  test 'finishes when given valid data' do
    form = stub(name: 'a-name', width: 1000, height: 200, x1: 0, y1: 0)

    story = stub()
    # It must set the story thumb accordingly
    story.expects(:set_thumb!).with('a-file')

    service = stub()
    service.stubs(:path).returns('a-path')
    # It must delete the old file
    service.expects(:delete).with('a-name').returns(true)
    PersistanceService.stubs(:new).returns(service)

    image_service = stub(crop: 'a-file')
    CropImage.stubs(:new).returns(image_service)

    action = FinishThumb.new(form, story)
    action.finish
  end
end
