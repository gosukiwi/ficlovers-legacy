# Holds an uploaded image, and crops it.
class CropThumb
  # 512kb in bytes
  MAX_SIZE = 512 * 1024

  def initialize(story)
    @path = Pathname.new "#{Rails.root}/public/tmp/thumbs"
    FileUtils.mkdir_p @path unless File.directory? @path
    @story = story
  end

  # Run action:
  # Crop an existing temporal file and removes it
  def crop(form)
    raise ValidationError, form.errors unless form.valid?

    result = crop_image form, quality
    @story.set_thumb File.open(result.path)
    @story.save
    delete name
  end

  # Prepare action:
  # Create a temporal file, saving the full image that must be cropped
  # Returns the name of the file, needed in the `crop` method.
  def prepare(form)
    raise ValidationError, form.errors unless form.valid?
    name = write_file form.thumb, "#{SecureRandom.uuid}.jpg"
    { name: name, path: path(name) }
  end

  protected

    def path(name)
      "/tmp/thumbs/#{name}"
    end

    def delete(name)
      FileUtils.rm @path.join(name)
    end

    # Create a new file cropping the one located in `path`
    def crop_image(form, quality = 60)
      MiniMagick::Image.new @path.join(form.name) do |img|
        img.quality quality.to_s
        img.crop "#{form.width}x#{form.height}+#{form.x1}+#{form.y1}"
      end
    end

    # Writes the file to disk (saving it) and returns the file name or nil if
    # file was not saved. Errors are stored in @errors
    def write_file(uploaded_io, name)
      File.open @path.join(name), 'wb' do |file|
        file.write uploaded_io.read
      end
      name
    end
end
