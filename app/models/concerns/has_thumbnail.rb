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

  included do
    after_initialize :construct
    attr_accessor :service
  end

  def set_thumb(file)
    self.thumb_url = upload file
  end

  def has_thumb?
    !thumb_url.nil?
  end

  private

    def upload(file)
      extension = File.extname file.path
      @service.put file, "#{self.id}_thumb#{extension}"
    end

    def construct
      @service = S3Service.new
    end
end
