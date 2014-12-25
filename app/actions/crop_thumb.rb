# Holds an uploaded image, and crops it.
class CropThumb
  def initialize(options = {})
    @path = Pathname.new "#{Rails.root}/public/tmp/thumbs"
    FileUtils.mkdir_p @path unless File.directory? @path

    @options = { quality: 60 }.merge options
  end

  # Run action:
  # Crop an existing temporal file and removes it
  def run(story: story, name: name, x1: x1, y1: y1, width: width, height: height)
    result = crop_image name, x1, y1, width, height
    story.set_thumb File.open(result.path)
    delete name
  end

  # Prepare action:
  # Create a temporal file, saving the full image that must be cropped
  # Returns the name of the file, needed in the `run` method.
  def prepare(uploaded_io)
    name = "#{SecureRandom.uuid}.jpg"
    write_file uploaded_io, name
    name
  end

  def path(name)
    "/tmp/thumbs/#{name}"
  end

  protected
    def delete(name)
      FileUtils.rm @path.join(name)
    end

    # Create a new file cropping the one located in `path`
    def crop_image(name, x1, y1, w, h)
      MiniMagick::Image.new @path.join(name) do |img|
        img.quality @options[:quality].to_s
        img.crop "#{w}x#{h}+#{x1}+#{y1}"
      end
    end

    def write_file(uploaded_io, name)
      File.open @path.join(name), 'wb' do |file|
        file.write uploaded_io.read
      end
    end
end
