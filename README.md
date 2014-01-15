# S3log

[![Gem Version](https://badge.fury.io/rb/s3log.png)](http://rubygems.org/gems/s3log)
[![Dependency Status](https://gemnasium.com/eduvo/s3log.png)](https://gemnasium.com/eduvo/s3log)

Downloader for aws S3 logs and agglomerator.

On S3 buckets you can activate logging, but the options are quite limited. You can point the logging to another bucket in the same region only and logging will generate a lot of small logging files, and will not delete them. It's not very convenient for debugging.

S3log script is intended to transform this logging in a unified logfile wherever you need it, removing the logfiles from the logging bucket when they are downloaded.

It's designed to run on debian/ubuntu servers but should work on any linux server, and it also work on mac osx. It works with ruby 1.9 and 2.0 (but not 1.8).

(work in progress, not ready for use yet, check the [Changelog](CHANGELOG.md)).

## Installation

    gem install s3log
    s3log init      # this will create a s3log/ dir at your current location

    cd s3log/
    vi config.yml   # customize according to your need
    s3log buckets   # this will verify the list of buckets that your credential give access to
    s3log list      # this will list the logfiles that will be candidate for downloading

## Usage

First you need to edit the config.yml file. The purpose is to have one config file per bucket you want to retrieve, so you can create as many config files as you need.

* jobname: the unique identifier for that job
* awspublic: the AWS access key
* awsprivate: the AWS secret key id
* bucket: the name of the bucket, with no s3:// prefix
* prefix: the path and prefix the same way you specified it in the logging setup
* logdir: the local dir where s3log logs are kept
* loglevel: the level of logging. use warn for only error display, info to record info on operations, debug to have much more details
* outputfile: the faile where the downloaded logs are going to be appended
* schedule: the cron formatted frequency of downloading the logs from bucket ie. `*/5 * * * *`

When your configuration is ready, veridy that it works with

    s3log list
    s3log list -c another_config.yml

Then you can update the user crontab for each config file.

    s3log schedule
    s3log schedule -c another_config.yml

The `schedule` command will update the user crontab, that you can verify with `crontab -l`.
In all s3log commands if you don't specify the config file with `-c`, it will use `config.yml`.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## author

* mose

## License

Copyright (c) 2014 Faria Systems Inc. distributed under MIT license
