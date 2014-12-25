class TempStorageService
  def initialize
    @path = Pathname.new "#{Rails.root}/public/temp-storage-service"
    FileUtils.mkdir_p @path unless File.directory? @path
  end

  def put(uploaded_io)
    name = "#{uuid}.jpg"
    write_file uploaded_io, name
    name
  end

  def get(name)
    @path.join(name)
  end

  def get_path(name)
    "/temp-storage-service/#{name}"
  end

  def delete(name)
    FileUtils.rm @path.join(name)
  end

  protected

    def uuid
      SecureRandom.uuid
    end

    def write_file(uploaded_io, name)
      File.open @path.join(name), 'wb' do |file|
        file.write uploaded_io.read
      end
    end
end
