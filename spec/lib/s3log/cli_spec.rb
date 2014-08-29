# encoding: utf-8

require 'spec_helper'
require 's3log/cli'

describe S3log::Cli do

  before :each do
    @cli = S3log::Cli.new([], { 'configfile' => 'config.yml' })
    @testdir = File.join('spec','files','init')
    @cli.shell.mute do
      @cli.init(@testdir)
    end
    @oldpwd = Dir.pwd
    Dir.chdir @testdir
  end

  after :each do
    Dir.chdir @oldpwd
    FileUtils.rm_rf @testdir if Dir.exists? @testdir
  end

  it "init creates a working directory" do
    expect(File.file? 'config.yml').to be_truthy
  end

end
