class PrepareThumb
  attr_reader :form
  def initialize(form, persistance = nil)
    @form = form
    @persistance = persistance
  end

  def persistance
    @persistance ||= PersistanceService.new
  end

  def put(file, name)
    persistance.put file, name
  end

  def thumb
    form.thumb
  end

  def uniq_name
    "#{SecureRandom.uuid}.jpg"
  end

  def prepare
    raise ActionError, form.errors unless form.valid?

    name = uniq_name
    put thumb, name
    { name: name, path: "/tmp/thumbs/#{name}" }
  end
end
