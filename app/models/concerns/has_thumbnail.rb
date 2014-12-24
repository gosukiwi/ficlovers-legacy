# Add thumbnail functionality to models.
# In order to work, the model needs the following attributes:
# thumb_path:string, thumb_expiration:datetime, thumb_temp_url:string
#
# Right now it uses DropboxThumbService to save thumbnails, this could be any
# service (PORO) which implements `get_thumb` and `set_thumb`.
module HasThumbnail
  extend ActiveSupport::Concern

  def get_thumb
    @thumb_service ||= DropboxThumbService.new self
    @thumb_service.get_thumb
  end

  def set_thumb
    thumb_service = ThumbnailService.new self
    thumb_service.set_thumb params[:thumb]
  end

  def expired?
    DateTime.now > thumb_expiration
  end

  def has_thumb?
    !thumb_path.nil?
  end
end
