# Receives and validates the new thumb form
class ThumbUploadForm
  attr_reader :thumb, :max_size, :errors
  def initialize(params, max_size = 512)
    @thumb = params[:thumb]
    # max KB allowed (unit is bytes)
    @max_size = max_size * 1024
    @errors = []
  end

  def add_error(error)
    errors << error
  end

  def valid?
    validate
    errors.empty?
  end

  def validate
    return add_error 'Thumb cannot be empty.' if thumb.nil?

    if thumb.size > max_size 
      add_error "Thumb file cannot be bigger than #{max_size / 1024} KB."
    end
    
    unless ['image/gif', 'image/jpeg', 'image/jpg', 'image/png'].include? thumb.content_type
      add_error 'Thumb MIME type is invalid, only images are allowed.'
    end
  end
end
