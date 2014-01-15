module S3log
  class Cron

    def initialize(configfile)
      @configfile = configfile
      @config = YAML::load_file(configfile)
      @path = File.dirname(configfile)
      @jobname = @config['jobname']
      @schedule = @config['schedule']
      @logdir = @config['logdir']
      FileUtils.mkdir(@logdir) unless Dir.exists? @logdir
      S3log::Log.set_logger(File.join(@logdir, 's3log.log'), @config['loglevel'])
    end

    def update
      line = "#{@schedule} cd #{@path} && bash -l -c 'bundle exec s3log download -c #{@configfile} >> /dev/null 2>&1' # s3log_#{@jobname}\n"
      tmp_cron_file = Tempfile.open('tmp_cron')
      included = false
      existing.each_line do |l|
        if l =~ Regexp.new("# s3log_#{@jobname}")
          tmp_cron_file << line
          included = true
        else
          tmp_cron_file << l
        end
      end
      tmp_cron_file << "# S3log job #{@jobname}\n#{line}" unless included
      tmp_cron_file.fsync
      if system("crontab #{tmp_cron_file.path}")
        S3log::Log.info "[update] crontab updated."
      else
        S3log::Log.warn "[fail] Couldn't write crontab."
        tmp_cron_file.close!
        exit(1)
      end
    end

    def existing
      existing = %x(crontab -l 2> /dev/null)
      if $?.exitstatus.zero?
        existing
      else
        ""
      end
    end

  end
end
