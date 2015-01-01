class CropThumb
  attr_reader :form, :story
  def initialize(story, form)
    @story = story
    @form  = form
  end

  # Copy the thumb file into the story, no longer need the file
  def save_thumb(path)
    story.set_thumb! File.open(path)
  end

  # The temporary file name the form uploaded
  def temp_file
    form.name
  end

  # The dimensions of the selected crop area
  def dimensions
   "#{form.width}x#{form.height}+#{form.x1}+#{form.y1}"
  end

  def image
    @image ||= MiniMagick::Image.new(path)
  end

  def persistance
    @persistance ||= PersistanceService.new
  end

  def unlink
    persistance.delete temp_file
  end

  def path
    persistance.path temp_file
  end

  def crop
    raise ActionError, form.errors unless form.valid?

    path = crop_image.path
    save_thumb path
    unlink
  end

  protected

    # Crop an existing file in-place
    def crop_image(quality = 80)
      image.combine_options do |img|
        img.quality quality.to_s
        img.crop dimensions
      end
    end
end
