# Add thumbnail functionality to models.
# In order to work, the model needs the following attributes:
#  thumb_url:string
#
# Right now it uses S3 to save thumbnails but this could be any file
# persistance service (a PORO which implements `put` and returns an url).
#
# To change the thumb service, from withing the model just set @service to a
# valid instance of your service.
module HasThumbnail
  extend ActiveSupport::Concern

  # 512kb in bytes
  # TODO: Be able to easily this somehow
  MAX_SIZE = 512 * 1024

  included do
    after_initialize :construct
    attr_accessor :thumb_persistance_service
  end

  def set_thumb(file)
    self.thumb_url = upload file
  end

  def has_thumb?
    !thumb_url.nil?
  end

  protected

    def upload(file)
      extension = File.extname file.path
      @thumb_persitance_service.put file, "#{self.id}_thumb#{extension}"
    end

    def construct
      @thumb_persitance_service = S3Service.new
    end
end
