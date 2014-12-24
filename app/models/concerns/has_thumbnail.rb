module HasThumbnail
  extend ActiveSupport::Concern

  module ClassMethods
    def thumb_url
      return if not has_thumb?
      @fetch_service ||= FetchThumb.new(self)
      @fetch_service.fetch
    end

    def expired?
      DateTime.now > self.thumb_expiration
    end

    def has_thumb?
      !self.thumb_path.nil?
    end
  end
end
