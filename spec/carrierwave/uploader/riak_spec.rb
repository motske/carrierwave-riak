require 'spec_helper'

describe CarrierWave::Uploader::Riak do

  let(:uploader) { ModelUploader.new }
  
  before(:each) { uploader.stub(:model).and_return(Model.new) }

  it "is inspectable" do
    expect(uploader.inspect).to eq(%Q[#<ModelUploader key="some_key" bucket="some_bucket">])
  end

  let(:model) { ActiveRecordModel.new }
  let(:file) { File.open 'spec/fixtures/test.txt' }

  before :each do
    file.stub(:content_type).and_return("text/plain")
  end

  it "removes the cached file after pushing to Riak" do
    model.upload = file
    model.store_upload!
    expect(model.upload.path).to be_false
  end

  it "leaves the cached file if move_to_storage returns false" do
    uploader.stub(:move_to_store).and_return(false)
    uploader.store!
    expect(model.upload.path).to be_nil
  end

  context "when using ActiveRecord" do

    before :each do
      model.upload = file
      model.store_upload!
    end

    it "sets the 'mounted_as' attribute on the model equal to the key" do
      expect(model[:upload]).to eq("some_key")
    end

  end

end
