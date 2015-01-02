class CropImage
  attr_reader :path
  def initialize(path, dimensions)
    @path = path
    @dimensions = dimensions
  end

  def image
    @image ||= MiniMagick::Image.new(path)
  end

  def dimensions
   "#{@dimensions[:width]}x#{@dimensions[:height]}+#{@dimensions[:x1]}+#{@dimensions[:y1]}"
  end

  # Crops the image in the given path using the specified dimensions and returns
  # a File object.
  def crop(quality = 80)
    result = image.combine_options do |img|
      img.quality quality.to_s
      img.crop dimensions
    end
    File.open result.path
  end
end
