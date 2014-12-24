require "dropbox_sdk"

class DropboxService
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
