class Model 

  extend CarrierWave::Mount

  mount_uploader :upload, ModelUploader

  def key
    "some_key"
  end

  def bucket
    "some_bucket"
  end

  def read_uploader(column)
    key
  end

end
