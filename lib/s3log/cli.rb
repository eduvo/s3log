require "thor"

module S3log

  class Cli < Thor
    include Thor::Actions

    def self.source_root
      File.expand_path("../../../templates", __FILE__)
    end

    default_task :help
    class_option :configfile,
      aliases: "-c",
      banner: "PATH",
      default: File.expand_path("config.yml", Dir.pwd),
      desc: "Path to the configuration file to use"

    desc "init", "Creates a s3log dir with default config files."
    def init(name="s3log")
      directory "s3log", name
    end

    desc "list", "Lists log files that are waiting on the S3 bucket."
    def list
      @s3log = S3log::Runner.new(options[:configfile])
      @s3log.items.each do |o|
        puts o
      end
    end

    desc "buckets", "List available buckets."
    def buckets
      @s3log = S3log::Runner.new(options[:configfile])
      @s3log.buckets
    end

    desc "download", "Downloads and delete logs from the logging S3 bucket."
    def download
      @s3log = S3log::Runner.new(options[:configfile])
      @s3log.download
    end

    desc "schedule", "Install cronjob for S3 logs download and agglomeration."
    def schedule
      @cron = S3log::Cron.new(options[:configfile])
      @cron.update
    end

  end

end
