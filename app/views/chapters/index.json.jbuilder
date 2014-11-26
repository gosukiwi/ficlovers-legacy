json.array!(@chapters) do |chapter|
  json.extract! chapter, :id, :title, :story_id, :content
  json.url chapter_url(chapter, format: :json)
end
