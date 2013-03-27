ActiveRecord::Schema.define do
  self.verbose = false

  create_table :active_record_models, :force => true do |f|
    f.string   :upload
  end
end
