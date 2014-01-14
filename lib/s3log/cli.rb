require "thor"
require "s3log"

module S3log

  class Cli < thor
    include Thor::Actions

    default_task :help

    desc "download", "Downloads and delete logs from the logging S3 bucket."
    def download
    end

    desc "agglomerate", "Gather daily logs in a single file"
    def agglomerate
    end

  end

end