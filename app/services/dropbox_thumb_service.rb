require "dropbox_sdk"

# A Thumbnail service which uses Dropbox as the persistance service
# An ENV variable 'FANFIC_DROPBOX_TOKEN' must exist and contain the access token
# for the account to be used to store data.
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

    def save_file(file)
      thumb_name = "/#{@story.id}_thumb#{File.extname(file.path)}"
      @dropbox.put_file thumb_name, file, true
    end
  
    def refresh
      file = @dropbox.get_temp_file_url @story.thumb_path
      @story.thumb_temp_url = file['url']
      @story.thumb_expiration = DateTime.parse file['expires']
      @story.save
    end

  # A service used to talk with Dropbox. Uses Dropbox-SDK as dependency.
  class DropboxService
    attr_accessor :client

    def initialize
      raise 'Dropbox token not defined' unless ENV.has_key? 'FANFIC_DROPBOX_TOKEN'
      @client = DropboxClient.new(ENV['FANFIC_DROPBOX_TOKEN'])
    end

    # Saves a file and returns it's metadata
    def put_file(name, content, force = false)
      @client.put_file name, content, force
    end

    # Gets a temporal url for a file. Returns in the format 
    # { url: 'http://...', expires: 'Thu, 16 Sep 2011 01:01:25 +0000' }
    def get_temp_file_url(path)
      @client.media path
    end
  end
end
