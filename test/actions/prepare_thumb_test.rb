class PrepareThumbTest < ActiveSupport::TestCase
  test 'prepare with valid form' do
    form = stub()
    form.stubs(:thumb)
    form.stubs(:valid?).returns(true)

    persistance = stub()
    persistance.stubs(:new).returns(persistance)
    persistance.stubs(:put)

    action = PrepareThumb.new form, persistance
    result = action.prepare
    assert_not_nil result[:name]
    assert_not_nil result[:path]
  end

  test 'prepare with invalid form' do
    form = stub()
    form.stubs(:thumb)
    form.expects(:valid?).returns(false)
    form.stubs(:errors).returns(['something went wrong!'])

    persistance = stub()
    persistance.stubs(:new).returns(persistance)
    # invalid form must never call service's put
    persistance.expects(:put).never

    action = PrepareThumb.new form, persistance

    assert_raises ActionError do
      action.prepare
    end
  end
end
