# Add thumbnail functionality to models.
# In order to work, the model needs the following attributes:
# thumb_path:string, thumb_expiration:datetime, thumb_temp_url:string
#
# Right now it uses DropboxThumbService to save thumbnails but this could be
# any thumbnail service (a PORO which implements `get_thumb` and `set_thumb`).
#
# To change the thumb service, from withing the model just set @thumb_service
# to a valid instance of your service.
module HasThumbnail
  extend ActiveSupport::Concern

  included do
    after_initialize :construct
    attr_accessor :thumb_service
  end

  def get_thumb
    @thumb_service.get_thumb
  end

  def set_thumb(uploaded_file)
    @thumb_service.set_thumb uploaded_file
  end

  def expired?
    DateTime.now > thumb_expiration
  end

  def has_thumb?
    !thumb_path.nil?
  end

  private

    def construct
      @thumb_service = DropboxThumbService.new self
    end
end
