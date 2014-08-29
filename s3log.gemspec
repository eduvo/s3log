# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 's3log/version'

Gem::Specification.new do |spec|
  spec.name          = "s3log"
  spec.version       = S3log::VERSION
  spec.authors       = ["mose"]
  spec.email         = ["mose@mose.com"]
  spec.description   = %q{Downloader for aws S3 logs.}
  spec.summary       = %q{Downloader for aws S3 logs, scheduler agglomerator.}
  spec.homepage      = "https://github.com/eduvo/s3log"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^spec/})
  spec.require_paths = ["lib"]

  spec.add_dependency "thor"
  spec.add_dependency "aws-sdk"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "rake"
end
