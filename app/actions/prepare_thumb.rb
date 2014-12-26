class PrepareThumb
  def initialize(form, service = PersistanceService)
    @form = form
    @persistance = service.new
  end

  def prepare
    raise ActionError, @form.errors unless @form.valid?

    name = "#{SecureRandom.uuid}.jpg"
    @persistance.put @form.thumb, name
    { name: name, path: "/tmp/thumbs/#{name}" }
  end
end
