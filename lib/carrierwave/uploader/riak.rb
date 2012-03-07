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
          if(model.read_attribute(:"#{self.mounted_as}").nil?)
            model.update_attribute(:"#{self.mounted_as}", self.key)
          end
        end
      end
    end
  end
end
