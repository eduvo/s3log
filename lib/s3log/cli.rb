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

    desc "download", "Downloads and delete logs from the logging S3 bucket."
    def download
    end

    desc "agglomerate", "Gather daily logs in a single file."
    def agglomerate
    end

    desc "schedule", "Install cronjob for S3 logs download and agglomeration."
    def schedule
    end

  end

end