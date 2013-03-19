class ModelUploader < CarrierWave::Uploader::Riak

  delegate :key, :bucket, to: :model

end
