require 'aws-sdk'

module S3log

  class Runner

    def initialize(configfile)
      @config = YAML::load_file(configfile)
      @s3 = AWS::S3.new(
        access_key_id: @config['awspublic'],
        secret_access_key: @config['awsprivate']
      )
      @bucket = @s3.buckets[@config['bucket']]
      @prefix = @config['prefix']
    end

    def list
      @bucket.objects.with_prefix(@prefix).each do |o|
        puts o.key
      end
    end

    def buckets
      @s3.buckets.each do |bucket|
        puts bucket.name
      end
    end

  end

end
