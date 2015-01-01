# Receives and validates the new thumb form
class ThumbUploadForm
  attr_reader :thumb, :max_size, :min_width, :min_height, :errors
  def initialize(params, max_size: 512, min_width: 500, min_height: 111)
    @thumb = params[:thumb]
    # max KB allowed (unit is bytes)
    @max_size   = max_size * 1024
    @min_width  = min_width
    @min_height = min_height
    @errors = []
  end

  def image_service
    @image_service ||= FastImage
  end

  def valid?
    validate
    errors.empty?
  end

protected

  def add_error(error)
    errors << error
  end

  def dimensions
    return @dimensions if @dimensions
    width, height = image_service.size thumb.path
    @dimensions = { width: width, height: height }
  end

  def valid_width?
    dimensions[:width] > min_width
  end

  def valid_height?
    dimensions[:height] > min_height
  end
  
  def valid_size?
    thumb.size < max_size
  end

  def valid_type?
    ['image/gif', 'image/jpeg', 'image/jpg', 'image/png'].include? thumb.content_type
  end

  def validate
    return add_error 'Thumb cannot be empty.' if thumb.nil?

    add_error "Thumb file cannot be bigger than #{max_size / 1024} KB." unless valid_size?
    return add_error 'Thumb MIME type is invalid, only images are allowed.' unless valid_type?

    add_error "Thumb width must be at least #{min_width} pixels" unless valid_width?
    add_error "Thumb height must be at least #{min_height} pixels" unless valid_height?
  end
end
