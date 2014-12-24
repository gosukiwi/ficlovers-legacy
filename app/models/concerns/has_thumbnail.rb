module HasThumbnail
  extend ActiveSupport::Concern

  def thumb_url
    @thumb_service ||= ThumbnailService.new self
    @thumb_service.get_thumb
  end

  def expired?
    DateTime.now > thumb_expiration
  end

  def has_thumb?
    !thumb_path.nil?
  end
end
