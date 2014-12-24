# Manages the story's attached thumb image and syncs it with Dropbox
class StoryThumb
  attr_accessor :story

  def initialize(story)
    @story = story
    @fetch_service = FetchThumb.new(self)
  end

  def thumb_url
    return if not has_thumb?
    @fetch_service.fetch
  end

  def expired?
    DateTime.now > @story.thumb_expiration
  end

  def has_thumb?
    !@story.thumb_path.nil?
  end
end
