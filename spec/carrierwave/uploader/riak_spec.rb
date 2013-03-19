require 'spec_helper'

describe CarrierWave::Uploader::Riak do

  let(:uploader_class) { 
    Class.new(described_class) {
      def self.name
        "SomeUploader"
      end

      def bucket
        "some_bucket"
      end
    }
  }

  let(:uploader) { 
    uploader_class.new.tap { |u|
      u.stub(:key).and_return("some_key")
    }
  }

  it "is inspectable" do
    expect(uploader.inspect).to eq(%Q[#<SomeUploader key="some_key" bucket="some_bucket">])
  end

end
