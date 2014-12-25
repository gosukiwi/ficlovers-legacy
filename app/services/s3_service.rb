gem 'aws-sdk'

class S3Service
  def initialize
    AWS.config access_key_id: ENV['FANFIC_S3_KEY'], secret_access_key: ENV['FANFIC_S3_SECRET']
    @bucket = AWS::S3.new.buckets[ENV['FANFIC_S3_BUCKET']]
  end

  def put(file, name)
    obj = @bucket.objects["thumbs/#{name}"]
    result = obj.write file, acl: :public_read
    "https://#{result.bucket.name}.s3.amazonaws.com/#{result.key}"
  end
end
