class ActionError < StandardError
  attr_reader :errors
  def initialize(errors)
    @errors = errors
  end
end
