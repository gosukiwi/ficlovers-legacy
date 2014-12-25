# Holds an uploaded image, and crops it.
class ThumbCropService
  def initialize
    @path = Pathname.new "#{Rails.root}/public/tmp/thumbs"
    FileUtils.mkdir_p @path unless File.directory? @path
  end

  # Crop an existing temporal file and remove it
  def crop(name, x1, y1, w, h)
    result = crop_image name, x1, y1, w, h
    delete name
    result
  end

  # Create a temporal file, preparing the image to be cropped
  def prepare(uploaded_io)
    name = "#{SecureRandom.uuid}.jpg"
    write_file uploaded_io, name
    name
  end

  def path(name)
    "/tmp/thumbs/#{name}"
  end

  protected
    # Create a new file cropping the one located in `path`
    def crop_image(name, x1, y1, w, h)
      image = MiniMagick::Image.open @path.join(name)
      image.crop "#{w}x#{h}+#{x1}+#{y1}"
      image.format "jpg"
      image
    end

    def delete(name)
      FileUtils.rm @path.join(name)
    end

    def write_file(uploaded_io, name)
      File.open @path.join(name), 'wb' do |file|
        file.write uploaded_io.read
      end
    end
end
