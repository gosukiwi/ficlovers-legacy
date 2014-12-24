module HasThumbnailHelper
  def thumb_for(item, options = {})
    tag :img, { src: item.get_thumb }.merge(options)
  end

  def thumb_background_for(item)
    return '' unless item.get_thumb
    "background: url(#{item.get_thumb}) 0 50%; background-size: cover;"
  end
end
