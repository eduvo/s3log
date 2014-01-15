# S3log

Downloader for aws S3 logs and agglomerator.

On S3 buckets you can activate logging, but the options are quite limited. You can point the logging to another bucket in the same region only and logging will generate a lot of small logging files, and will not delete them. It's not very convenient for debugging.

S3log script is intended to transform this logging in a unified logfile wherever you need it, removing the logfiles from the logging bucket when they are downloaded.

(work in progress, not ready for use yet).

## Installation

    gem install s3log
    s3log init      # this will create a s3log/ dir at your current location

    cd s3log/
    vi config.yml   # customize according to your need
    s3log buckets   # this will verify the list of buckets that your credential give access to
    s3log list      # this will list the logfiles that will be candidate for downloading

## Usage

TODO: Write usage instructions here

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
