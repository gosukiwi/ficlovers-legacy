require "dropbox_sdk"

# A service used to talk with Dropbox. Uses Dropbox-SDK as dependency.
# An ENV variable 'FANFIC_DROPBOX_TOKEN' must exist and contain the access token
# for the account to be used to store data.
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
