require 'carrierwave'
require 'riak'

module CarrierWave
  module Uploader
    class Riak < Base

      attr_accessor :key

      storage :riak

      if defined?(Rails)
        after :store, :updatemodel

        def updatemodel(file)
          Rails.logger.debug("BEGIN update_model #{self.mounted_as}_identifier")
          if(model.read_attribute(:"#{self.mounted_as}").nil?)
            model.update_attribute(:"#{self.mounted_as}", self.key)
          end
          Rails.logger.debug("END update_model")
        end
      end
    end
  end
end
