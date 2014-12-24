# Add thumbnail functionality to models.
# In order to work, the model needs the following attributes:
# thumb_path:string, thumb_expiration:datetime, thumb_temp_url:string
#
# Right now it uses DropboxThumbService to save thumbnails but this could be
# any thumbnail service (a PORO which implements `get_thumb` and `set_thumb`).
module HasThumbnail
  extend ActiveSupport::Concern

  included do
    after_initialize :set_thumb_service
  end

  def get_thumb
    @thumb_service.get_thumb
  end

  def set_thumb
    @thumb_service.set_thumb params[:thumb]
  end

  def expired?
    DateTime.now > thumb_expiration
  end

  def has_thumb?
    !thumb_path.nil?
  end
  
  private

    def set_thumb_service(service = nil)
      service = DropboxThumbService.new self if service.nil?
      @thumb_service = service
    end
end
