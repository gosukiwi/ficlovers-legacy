class FetchThumb
  def initialize(thumb)
    @thumb = thumb
    @story = thumb.story
    @dropbox = DropboxService.new
  end

  # Fetches an story's thumb, get's a new link if the old one has expired.
  def fetch
    refresh_link if @thumb.expired?
    @story.thumb_url
  end

  private
    
    def refresh_link
      file = @dropbox.get_temp_file_url @story.thumb_path
      @story.thumb_url = file['url']
      @story.thumb_expiration = DateTime.parse file['expires']
      @story.save
    end
end
