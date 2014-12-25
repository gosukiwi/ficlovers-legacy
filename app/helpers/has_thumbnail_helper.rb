module HasThumbnailHelper
  def thumb_for(item, options = {})
    url = item.thumb_url
    url += "?#{rand(0..999)}" if options[:bust_cache]
    tag :img, { src: url }.merge(options)
  end

  def thumb_background_for(item)
    return '' unless item.has_thumb?
    "background: url(#{item.thumb_url}) 0 50%; background-size: cover;"
  end
end
