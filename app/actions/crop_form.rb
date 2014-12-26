class CropForm
  def initialize(params)
    @params = params
  end

  def name
    @params[:key]
  end

  def x1
    @params[:x1].to_i || 0
  end

  def y1
    @params[:y1].to_i || 0
  end

  def width
    @params[:w].to_i
  end

  def height
    @params[:h].to_i
  end

  def valid?
    errors.count == 0
  end

  def errors
    errors = []
    
    if name.nil?
      errors << 'Image name cannot be empty'
    end

    if width.nil? || width <= 100
      errors << 'Width must be at least 100 pixels'
    end

    if height.nil? || height <= 20
      errors << 'Height must be at least 20 pixels'
    end

    errors
  end
end
