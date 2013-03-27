require 'spec_helper'

describe "Implementing CarrierWave with Riak backend" do

  let(:model) { Model.new }
  let(:file) { File.open 'spec/fixtures/test.txt' }
  
  before :each do
    file.stub(:content_type).and_return("text/plain")
    model.upload = file
  end

  it "stores and retrieves documents in Riak" do
    model.store_upload!
    expect(Model.new.upload.read).to include("testing purposes")
  end

end
