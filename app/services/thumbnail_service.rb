# Gets and sets thumbnails using dropbox
class ThumbnailService
  def initialize(story)
    @story = story
    @dropbox = DropboxService.new
  end

  def get_thumb
    return unless @story.has_thumb?
    refresh if @story.expired?
    @story.thumb_temp_url
  end

  def set_thumb(uploaded_file)
    thumb_name = "/#{@story.id}_thumb#{File.extname(uploaded_file.original_filename)}"
    result = @dropbox.put_file thumb_name, uploaded_file.read, true
    @story.thumb_path = result['path']
    refresh
  end

  private
  
    def refresh
      file = @dropbox.get_temp_file_url @story.thumb_path
      @story.thumb_temp_url = file['url']
      @story.thumb_expiration = DateTime.parse file['expires']
      @story.save
    end
end
