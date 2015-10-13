require 'test_helper'

class ChaptersApiTest < ActionDispatch::IntegrationTest
  def login_as(user)
    post '/login', { session: { username: user.username, password: user.password } }
  end

  def to_json(str)
    JSON.parse str, symbolize_names: true
  end

  test 'add chapter to story without logging in' do
    story = FactoryGirl.create(:story)

    post "/fics/#{story.id}/chapters", {
      title: 'This is a chapter title',
      content: 'This is the contentthe contentthe contentthe contentthe contentthe contentthe contentthe contentthe contentthe contentthe contentthe contentthe content'
    }.to_json, { 'Accept' => Mime::JSON, 'Content-Type' => Mime::JSON.to_s }

    # 401: unauthorized
    assert_equal 401, response.status
  end

  test 'add chapter to story' do
    story = FactoryGirl.create(:story)
    login_as story.user

    post "/fics/#{story.id}/chapters", {
      title: 'This is a chapter title',
      content: 'This is the contentthe contentthe contentthe contentthe contentthe contentthe contentthe contentthe contentthe contentthe contentthe contentthe content'
    }.to_json, { 'Accept' => Mime::JSON, 'Content-Type' => Mime::JSON.to_s }

    assert_equal 200, response.status
    assert_equal story.id, to_json(response.body)[:id]
  end

  test 'add invalid chapter to story' do
    story = FactoryGirl.create(:story)
    login_as story.user

    post "/fics/#{story.id}/chapters", {
      title: 'This is a chapter title',
      content: 'This content is too short'
    }.to_json, { 'Accept' => Mime::JSON, 'Content-Type' => Mime::JSON.to_s }

    assert_equal 422, response.status

    refute_empty to_json(response.body)[:content]
    assert_equal Mime::JSON, response.content_type
  end

  test 'update chapter from story' do
    chapter = FactoryGirl.create(:chapter)
    story = chapter.story
    login_as story.user

    patch "/fics/#{story.id}/chapters/#{chapter.id}", {
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

    delete "/fics/#{story.id}/chapters/#{chapter.id}", {}, { 'Accept' => Mime::JSON, 'Content-Type' => Mime::JSON.to_s }

    # 204: no_content
    assert_equal 204, response.status
  end
end
