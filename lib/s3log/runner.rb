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
      @logdir = @config['logdir']
      FileUtils.mkdir(@logdir) unless Dir.exists? @logdir
      S3log::Log.set_logger(File.join(@logdir, 's3log.log'), @config['loglevel'])
    end

    def items
      @_items ||= @bucket.objects.with_prefix(@prefix).collect(&:key)
    end

    def buckets
      @s3.buckets.each do |bucket|
        puts bucket.name
      end
    end

    def download
      if items.size > 0
        time = Time.now
        S3log::Log.info "Downloading #{items.size} file."
        File.open(@config['outputfile'], 'a+') do |f|
          items.each do |i|
            f.puts @bucket.objects[i].read
            S3log::Log.debug "    #{i} added."
            @bucket.objects[i].delete
          end
        end
        S3log::Log.info "... done in #{Time.now - time}s."
      else
        S3log::Log.debug "No file to download."
      end
    end

  end

end
