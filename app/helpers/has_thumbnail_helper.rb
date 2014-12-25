module HasThumbnailHelper
  def thumb_for(item, options = {})
    url = item.get_thumb
    url += "?#{rand(0..999)}" if options[:bust_cache]
    tag :img, { src: url }.merge(options)
  end

  def thumb_background_for(item)
    return '' unless item.get_thumb
    "background: url(#{item.get_thumb}) 0 50%; background-size: cover;"
  end
end
