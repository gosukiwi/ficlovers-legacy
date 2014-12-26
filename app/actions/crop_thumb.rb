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
  def run(name: name, x1: x1, y1: y1, width: width, height: height, quality: quality = 60)
    result = crop_image name, x1, y1, width, height, quality
    @story.set_thumb File.open(result.path)
    @story.save
    delete name
  end

  # Prepare action:
  # Create a temporal file, saving the full image that must be cropped
  # Returns the name of the file, needed in the `run` method.
  def prepare(uploaded_io)
    return unless @story.file_valid? uploaded_io
    write_file uploaded_io, "#{SecureRandom.uuid}.jpg"
  end

  def path(name)
    "/tmp/thumbs/#{name}"
  end

  protected
    def delete(name)
      FileUtils.rm @path.join(name)
    end

    # Create a new file cropping the one located in `path`
    def crop_image(name, x1, y1, w, h, q)
      MiniMagick::Image.new @path.join(name) do |img|
        img.quality q.to_s
        img.crop "#{w}x#{h}+#{x1}+#{y1}"
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
