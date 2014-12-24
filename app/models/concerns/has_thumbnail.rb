module HasThumbnail
  extend ActiveSupport::Concern

  def thumb_real_url
    @fetch_service ||= FetchThumb.new self
    @fetch_service.fetch
  end

  def expired?
    DateTime.now > thumb_expiration
  end

  def has_thumb?
    !thumb_path.nil?
  end
end
