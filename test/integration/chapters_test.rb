require 'test_helper'

class ChaptersApiTest < ActionDispatch::IntegrationTest
  def login_as(user)
    post '/login', { session: { email: user.email, password: user.password } }
  end

  test 'add chapter to story without logging in' do
    story = FactoryGirl.create(:story)

    post "/stories/#{story.id}/chapters", {
      title: 'This is a chapter title',
      content: 'This is the contentthe contentthe contentthe contentthe contentthe contentthe contentthe contentthe contentthe contentthe contentthe contentthe content'
    }.to_json, { 'Accept' => Mime::JSON, 'Content-Type' => Mime::JSON.to_s }

    # 401: unauthorized
    assert_equal 401, response.status
  end

  test 'add chapter to story' do
    story = FactoryGirl.create(:story)
    login_as story.user

    post "/stories/#{story.id}/chapters", {
      title: 'This is a chapter title',
      content: 'This is the contentthe contentthe contentthe contentthe contentthe contentthe contentthe contentthe contentthe contentthe contentthe contentthe content'
    }.to_json, { 'Accept' => Mime::JSON, 'Content-Type' => Mime::JSON.to_s }

    # 204: no_content
    assert_equal 204, response.status
  end

  test 'add invalid chapter to story' do
    story = FactoryGirl.create(:story)
    login_as story.user

    post "/stories/#{story.id}/chapters", {
      title: 'This is a chapter title',
      content: 'This content is too short'
    }.to_json, { 'Accept' => Mime::JSON, 'Content-Type' => Mime::JSON.to_s }

    assert_equal 422, response.status

    response_chapter = JSON.parse response.body, symbolize_names: true
    refute_empty response_chapter[:content]

    assert_equal Mime::JSON, response.content_type
  end

  test 'update chapter from story' do
    chapter = FactoryGirl.create(:chapter)
    story = chapter.story
    login_as story.user

    patch "/stories/#{story.id}/chapters/#{chapter.id}", {
      title: 'This is another title',
      content: chapter.content
    }.to_json, { 'Accept' => Mime::JSON, 'Content-Type' => Mime::JSON.to_s }

    # 204: no_content
    assert_equal 204, response.status
  end

  test 'delete chapter from story' do
    chapter = FactoryGirl.create(:chapter)
    story = chapter.story
    login_as story.user

    delete "/stories/#{story.id}/chapters/#{chapter.id}", {}, { 'Accept' => Mime::JSON, 'Content-Type' => Mime::JSON.to_s }

    # 204: no_content
    assert_equal 204, response.status
  end
end
