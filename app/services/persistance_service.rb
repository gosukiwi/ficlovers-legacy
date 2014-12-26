class PersistanceService
  def initialize(full_path = "#{Rails.root}/public/tmp/thumbs")
    @path = Pathname.new full_path
    FileUtils.mkdir_p @path unless File.directory? @path
  end

  def path(name)
    @path.join name
  end

  def put(file, name)
    File.open @path.join(name), 'wb' do |f|
      f.write file.read
    end
  end

  def delete(name)
    FileUtils.rm @path.join(name)
  end
end
