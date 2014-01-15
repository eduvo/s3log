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
      @tmpdir = @config['tmpdir']
      FileUtils.mkdir(@tmpdir) unless Dir.exists? @tmpdir
    end

    def items
      @bucket.objects.with_prefix(@prefix).collect(&:key)
    end

    def buckets
      @s3.buckets.each do |bucket|
        puts bucket.name
      end
    end

    def download
      File.open(@config['logfile'], 'a+') do |f|
        items.each do |i|
          f.puts @bucket.objects[i].read
          puts "#{i} added."
        end
      end
    end

  end

end
