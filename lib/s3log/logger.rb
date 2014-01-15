require "logger"

module S3log
  module Log
    extend self

    def set_logger(logfile, level="info")
      if logfile.is_a?(String) && !Dir.exists?(File.dirname(logfile))
        FileUtils.mkdir_p(File.dirname(logfile))
      end
      @logger = ::Logger.new(logfile)
      @logger.level = get_level_constant(level)
      @logger.formatter = proc do |severity, datetime, progname, msg|
        "[#{datetime.utc}] #{severity}: #{msg}\n"
      end
    end

    def logger
      @logger ||= ::Logger.new(STDOUT)
    end

    def debug(msg)
      logger.debug(msg)
    end

    def info(msg)
      logger.info(msg)
    end

    def warn(msg)
      logger.warn(msg)
    end

    def error(msg)
      logger.error(msg)
    end

    def fatal(msg)
      logger.fatal(msg)
    end

    def get_level_constant(level)
      if level
        begin
          ::Logger.const_get(level.to_s.upcase)
        rescue NameError
          return ::Logger::INFO
        end
      else
        ::Logger::INFO
      end
    end

  end
end
