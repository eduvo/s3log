$LOAD_PATH << File.expand_path('../../lib', __FILE__)
require 'rubygems'
require 'bundler'

RSpec.configure do |config|
  config.mock_with :rspec
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
