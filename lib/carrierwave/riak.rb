require "carrierwave/storage/riak"
require "carrierwave/riak/configuration"
CarrierWave.configure do |config|
  config.storage_engines.merge!({:riak => "CarrierWave::Storage::Riak"})
end

CarrierWave::Uploader::Base.send(:include, CarrierWave::Riak::Configuration)
require "carrierwave/uploader/riak"