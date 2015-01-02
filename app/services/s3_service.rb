gem 'aws-sdk'

# Service to put and get files from Amazon S3
class S3Service
  def bucket
    @bucket ||= default_bucket
  end

  def get(name)
    bucket.objects["thumbs/#{name}"]
  end

  def url(obj)
    "https://#{obj.bucket.name}.s3.amazonaws.com/#{obj.key}"
  end

  def put(file, name)
    obj = get name
    obj.write file, acl: :public_read
    url obj
  end

  protected

    def default_bucket
      AWS.config access_key_id: ENV['FANFIC_S3_KEY'], secret_access_key: ENV['FANFIC_S3_SECRET']
      AWS::S3.new.buckets[ENV['FANFIC_S3_BUCKET']]
    end
end
