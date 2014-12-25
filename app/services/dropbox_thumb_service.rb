# A Thumbnail service which uses Dropbox as the persistance service
class DropboxThumbService
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
    result = save_file uploaded_file
    @story.thumb_path = result['path']
    refresh
  end

  private

    def save_file(uploaded_file)
      thumb_name = "/#{@story.id}_thumb#{File.extname(uploaded_file.original_filename)}"
      @dropbox.put_file thumb_name, uploaded_file.read, true
    end
  
    def refresh
      file = @dropbox.get_temp_file_url @story.thumb_path
      @story.thumb_temp_url = file['url']
      @story.thumb_expiration = DateTime.parse file['expires']
      @story.save
    end
end
