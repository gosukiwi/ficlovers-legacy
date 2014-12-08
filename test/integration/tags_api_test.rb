require 'test_helper'

class TagsApiTest < ActionDispatch::IntegrationTest
  test 'should insert new tag with valid values' do
    story = FactoryGirl.create(:story)
    assert_equal 0, story.tags.count
    post tags_url, { story_id: story.id, tag: { name: 'Hinata Hyuuga', context: 'characters' } }

    assert_equal 204, response.status
    assert_equal 1, story.reload.tags.count
  end

  #test 'should update a story tags accordingly' do
  #  story = FactoryGirl.create(:story)
  #  active_tag = FactoryGirl.create(:tag_active)
  #  story.tags << active_tag

  #  another_active = FactoryGirl.create(:tag_active)
  #  
  #  patch story, json
  #  assert_equal 1, story.tags.count
  #  assert_equal another_active, story.tags.first
  #end

  test 'should retrieve only active tags in search' do
    active_tag = FactoryGirl.create(:tag_active)
    pending_tag = FactoryGirl.create(:tag) 
    
    get search_tag_url(active_tag.context, active_tag.name[1, 4])

    assert_equal 200, response.status

    json = JSON.parse response.body, symbolize_names: true
    assert_equal active_tag.name, json.first[:name]
    assert_equal 1, json.count
  end
end
