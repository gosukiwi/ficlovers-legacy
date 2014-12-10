require 'test_helper'

class AdminPendingTagsWorkflowTest < ActionDispatch::IntegrationTest
  test 'can approve a tag' do
    user = FactoryGirl.create(:user_admin)
    login_as user

    tag = FactoryGirl.create(:tag)

    visit admin_tags_url
    has_content? tag.name

    find("##{tag.id}-actions .approve").click
    assert 'active', tag.reload.status
  end

  test 'can deny a tag' do
    user = FactoryGirl.create(:user_admin)
    login_as user

    tag = FactoryGirl.create(:tag)

    visit admin_tags_url
    has_content? tag.name

    find("##{tag.id}-actions .deny").click
    assert 'removed', tag.reload.status
  end
end
