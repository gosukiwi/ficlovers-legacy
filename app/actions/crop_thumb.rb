class CropThumb
  def initialize(story, form, service = PersistanceService)
    @story = story
    @form = form
    @persistance = service.new
  end

  def crop
    raise ActionError, @form.errors unless @form.valid?

    result = crop_image @form
    @story.set_thumb File.open(result.path)
    @story.save
    @persistance.delete @form.name
  end

  protected

    # Crop an existing file in-place
    def crop_image(form, quality = 60)
      MiniMagick::Image.new @persistance.path(form.name) do |img|
        img.quality quality.to_s
        img.crop "#{form.width}x#{form.height}+#{form.x1}+#{form.y1}"
      end
    end
end
