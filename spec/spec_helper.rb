require 'simplecov'
SimpleCov.start

require 'rubygems'
require 'rspec'
require 'rspec/autorun'
require 'rails'
require 'active_record'
require 'carrierwave'
require 'carrierwave/orm/activerecord'
require 'carrierwave/processing/mini_magick'
require 'riak/test_server'
require 'yaml'

ActiveRecord::Base.establish_connection(:adapter => "sqlite3", :database => ":memory:")

load File.expand_path('../support/schema.rb', __FILE__)

$LOAD_PATH.unshift(File.expand_path('../../lib', __FILE__))

require "carrierwave/riak"

require "support/model_uploader"
require "support/model"
require "support/active_record_model"

def Rails.root
  @root ||= Pathname.new(File.expand_path('..', __FILE__))
end

CarrierWave.configure do |config|
  config.storage = :riak
  config.riak_bucket = "rspec"
  config.riak_host = "localhost"
end

RSpec.configure do |config|

  config.order = :random

  config.before :suite do
    unless $test_server
      begin
        config = YAML.load_file('spec/support/test_server.yml')
        test_server = Riak::TestServer.create(config.symbolize_keys)
        test_server.start
      rescue => e
        warn "Can't run Riak::TestServer specs. Specify the location of your Riak installation in 'spec/support/test_server.yml. See warning e.inspect"
        puts e.inspect
        test_server = nil
      end
    end
  end

  config.after :suite do
    FileUtils.rm_rf(File.expand_path('../../uploads',     __FILE__))
    FileUtils.rm_rf(File.expand_path('../test_server', __FILE__))
  end

end
