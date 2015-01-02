class FinishThumb
  attr_reader :form, :story
  def initialize(form, story)
    @form = form
    @story = story
  end

  def persist
    @persist ||= PersistanceService.new
  end

  def finish
    story.set_thumb! crop_thumb
    persist.delete form.name
  end

protected

  def path
    persist.path form.name
  end

  def dimensions
    { width: form.width, height: form.height, x1: form.x1, y1: form.y1 }
  end

  def crop_thumb
    CropImage.new(path, dimensions).crop
  end
end
