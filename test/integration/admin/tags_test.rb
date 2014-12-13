require 'test_helper'

class AdminPendingTagsWorkflowTest < ActionDispatch::IntegrationTest
  test 'can approve a tag as fandom' do
    user = FactoryGirl.create(:user_admin)
    login_as user

    tag = FactoryGirl.create(:tag)

    assert 'pending', tag.status

    visit admin_tags_url

    find("##{tag.id}-actions .approve-fandom").click
    assert 'active', tag.reload.status
    assert 'fandoms', tag.context
  end

  test 'can approve a tag as genre' do
    user = FactoryGirl.create(:user_admin)
    login_as user

    tag = FactoryGirl.create(:tag) # is context characters by default

    assert 'pending', tag.status

    visit admin_tags_url

    find("##{tag.id}-actions .approve-genre").click
    assert 'active', tag.reload.status
    assert 'genres', tag.context
  end

  test 'can approve a tag as character' do
    user = FactoryGirl.create(:user_admin)
    login_as user

    tag = FactoryGirl.create(:tag) # is context characters by default

    assert 'pending', tag.status

    visit admin_tags_url

    find("##{tag.id}-actions .approve-character").click
    assert 'active', tag.reload.status
    assert 'characters', tag.context
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
