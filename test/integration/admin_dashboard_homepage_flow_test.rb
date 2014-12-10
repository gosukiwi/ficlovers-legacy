require 'test_helper'

class AdminDashboardHomepageFlowTest < ActionDispatch::IntegrationTest
  test 'only admins can see index' do
    user = FactoryGirl.create(:user_admin)
    login_as user

    visit admin_dashboard_url
    has_content? 'Welcome'
  end

  test 'tag list works' do
    user = FactoryGirl.create(:user_admin)
    login_as user

    tag = FactoryGirl.create(:tag)

    visit admin_dashboard_url
    click_on 'Manage tags'

    has_content? tag.name
  end
end
