class ActiveRecordModel < ActiveRecord::Base

  mount_uploader :upload, ModelUploader

  def key
    "some_key"
  end

  def bucket
    "some_bucket"
  end

end

