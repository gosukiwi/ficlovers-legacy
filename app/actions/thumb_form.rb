# Receives and validates the new thumb form
class ThumbForm
  attr_reader :thumb

  def initialize(params, max_size = 512)
    @thumb = params[:thumb]
    # max KB allowed (unit is bytes)
    @max_size = max_size * 1024
  end

  def valid?
    errors.count == 0
  end

  def errors
    errors = []

    if @thumb.nil?
      errors << 'Thumb cannot be empty.'
    else
      if @thumb.size > @max_size 
        errors << "Thumb file cannot be bigger than #{@max_size / 1024} KB."
      end
      
      unless ['image/gif', 'image/jpeg', 'image/jpg', 'image/png'].include? @thumb.content_type
        errors << 'Thumb MIME type is invalid, only images are allowed.'
      end
    end

    errors
  end
end
