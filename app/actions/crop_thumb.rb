class CropThumb
  attr_reader :form, :story
  def initialize(story, form)
    @story = story
    @form  = form
  end

  # The temporary file name the form uploaded
  def temp_file
    form.name
  end

  # The dimensions of the selected crop area
  def dimensions
   "#{form.width}x#{form.height}+#{form.x1}+#{form.y1}"
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

    thumb = File.open cropped_image
    story.set_thumb! thumb
    unlink
  end

  protected

    # Crop an existing file in-place
    def cropped_image(quality = 80)
      result = MiniMagick::Image.new path do |img|
        img.quality quality.to_s
        img.crop dimensions
      end
      result.path
    end
end
