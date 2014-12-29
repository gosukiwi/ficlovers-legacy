class PrepareThumbTest < ActiveSupport::TestCase
  test 'prepare with valid form' do
    form = stub()
    form.stubs(:thumb)
    form.expects(:valid?).returns(true)

    service = stub()
    service.stubs(:new).returns(service)
    # must call service's put method
    service.expects(:put)

    action = PrepareThumb.new form, service

    assert_not_nil action.prepare
  end

  test 'prepare with invalid form' do
    form = stub()
    form.stubs(:thumb)
    form.expects(:valid?).returns(false)
    form.stubs(:errors).returns(['something went wrong!'])

    service = stub()
    service.stubs(:new).returns(service)
    # invalid form must never call service's put
    service.expects(:put).never

    action = PrepareThumb.new form, service

    assert_raises ActionError do
      action.prepare
    end
  end
end
