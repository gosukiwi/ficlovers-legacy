module HasThumbnailHelper
  def thumb_url_for(story)
    story.thumb_url
  end

  def thumb_background_for(story)
    return '' unless story.thumb_url
    "background: url(#{story.thumb_url}) 0 50%; background-size: cover;"
  end
end
