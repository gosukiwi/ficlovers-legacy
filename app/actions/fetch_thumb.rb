class FetchThumb
  def initialize(story)
    @story = story
    @dropbox = DropboxService.new
  end

  # Fetches an story's story, get's a new link if the old one has expired.
  def fetch
    return if not @story.has_thumb?
    refresh if @story.expired?
    @story.thumb_url
  end

  private
    
    def refresh
      file = @dropbox.get_temp_file_url @story.thumb_path
      @story.thumb_url = file['url']
      @story.thumb_expiration = DateTime.parse file['expires']
      @story.save
    end
end
