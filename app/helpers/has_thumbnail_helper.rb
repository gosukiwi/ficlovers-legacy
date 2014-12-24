module HasThumbnailHelper
  def thumb_url_for(story)
    StoryThumb.new(story).thumb_url
  end

  def thumb_background_for(story)
    url = StoryThumb.new(story).thumb_url
    return '' unless url
    "background: url(#{url}) 0 50%; background-size: cover;"
  end
end
