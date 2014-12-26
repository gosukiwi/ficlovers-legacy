class ValidationError < StandardError
  def initialize(errors)
    @errors = errors
  end

  def errors
    @errors
  end
end
