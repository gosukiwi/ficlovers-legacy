# Manages the story's attached thumb image and syncs it with Dropbox
class StoryThumb
  def initialize(story)
    @story = story
    @dropbox = DropboxService.new
  end

  def upload(uploaded_file)
    thumb_name = "/#{@story.id}_thumb#{File.extname(uploaded_file.original_filename)}"
    result = @dropbox.put_file thumb_name, uploaded_file.read, true
    
    @story.thumb_path = result['path']
    refresh_thumb_url true
    @story.save
  end

  def thumb_url
    refresh_thumb_url!
    @story.thumb_url
  end

  def expired?
    DateTime.now > @story.thumb_expiration
  end

  def has_thumb?
    !@story.thumb_path.nil?
  end

  protected

    # Refresh the thumb URL if needed, if `force` is true, it will update the 
    # url even if it's not expired yet
    def refresh_thumb_url(force = false)
      # If this story does not have a thumb or if it's not expired yet, return
      return unless has_thumb? && expired? && !force

      file = @dropbox.get_temp_file_url @story.thumb_path
      @story.thumb_url = file['url']
      @story.thumb_expiration = DateTime.parse file['expires']
    end

    def refresh_thumb_url!(force = false)
      refresh_thumb_url force
      @story.save
    end
end
