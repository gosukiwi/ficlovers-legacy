class UploadThumb
  def initialize(uploaded_file, story)
    @uploaded_file = uploaded_file
    @story = story
    @dropbox = DropboxService.new
  end

  def upload
    thumb_name = "/#{@story.id}_thumb#{File.extname(@uploaded_file.original_filename)}"
    result = @dropbox.put_file thumb_name, @uploaded_file.read, true
    update_story! result['path']
  end

  private
  
    def update_story!(path)
      file = @dropbox.get_temp_file_url path
      @story.thumb_path = path
      @story.thumb_url = file['url']
      @story.thumb_expiration = DateTime.parse file['expires']
      @story.save
    end
end
