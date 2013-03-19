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

ActiveRecord::Base.establish_connection(adapter: "sqlite3", database: ":memory:")

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

  config.after :suite do
    FileUtils.rmdir(File.expand_path('../../uploads/tmp', __FILE__))
    FileUtils.rmdir(File.expand_path('../../uploads',     __FILE__))
  end

end
