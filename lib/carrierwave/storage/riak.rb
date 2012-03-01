# encoding: utf-8
require 'carrierwave'
require 'riak'

module CarrierWave
  module Storage

    ##
    #
    #     CarrierWave.configure do |config|
    #       config.riak_bucket = "my_bucket"
    #       config.riak_host = "http://localhost
    #       config.riak_port = 8098
    #     end
    #
    #
    class Riak < Abstract

      class Connection
        def initialize(options={})
          @riak_bucket = options[:riak_bucket]
          @host = options[:riak_host]
          @port = options[:riak_port]
          @client = ::Riak::Client.new(:host => @host, :http_port => @port)
        end

        def store(path, payload, headers = {})
          bucket = @client.bucket(@riak_bucket)
          robject = ::Riak::RObject.new(bucket, path)
          robject.content_type = headers[:content_type]
          robject.data = payload
          robject.store
          puts "key = #{robject.key}"
        end

        def get(path)
          bucket = client.bucket(@riak_bucket)
          bucket.get(path)
        end

        def delete(path, headers = {})
          @http["#{escaped(path)}"].delete(headers)
        end

        def post(path, payload, headers = {})
          @http["#{escaped(path)}"].post(payload, headers)
        end

        def escaped(path)
          CGI.escape(path)
        end
      end

      class File

        def initialize(uploader, base, path)
          @uploader = uploader
          @path = path
          @base = base
        end

        ##
        # Returns the current path/filename of the file on Cloud Files.
        #
        # === Returns
        #
        # [String] A path
        #
        def path
          @path
        end

        ##
        # Reads the contents of the file from Cloud Files
        #
        # === Returns
        #
        # [String] contents of the file
        #
        def read
          riak_client.get(@path)
        end

        ##
        # Remove the file from Cloud Files
        #
        def delete
          begin
            uy_connection.delete(@path)
            true
          rescue Exception => e
            # If the file's not there, don't panic
            nil
          end
        end

        ##
        # Returns the url on the Cloud Files CDN.  Note that the parent container must be marked as
        # public for this to work.
        #
        # === Returns
        #
        # [String] file's url
        #
        def url
          if @uploader.upyun_bucket_domain
            "http://" + @uploader.upyun_bucket_domain + '/' + @path
          else
            nil
          end
        end

        ##
        # Writes the supplied data into the riak db
        #
        # === Returns
        #
        # boolean
        #
        def store(data,headers={})
          puts "about to store riak file with data #{data}"
          riak_client.store(@path, data, headers)
          true
        end

        private

          def headers
            @headers ||= {  }
          end

          def connection
            @base.connection
          end

          def riak_client
            if @riak_client
              @riak_client
            else
              config = {
                :riak_bucket => @uploader.riak_bucket,
                :riak_host => @uploader.riak_host,
                :riak_port => @uploader.riak_port
              }
              @riak_client ||= CarrierWave::Storage::Riak::Connection.new(config)
            end
          end

      end

      ##
      # Store the file on UpYun
      #
      # === Parameters
      #
      # [file (CarrierWave::SanitizedFile)] the file to store
      #
      # === Returns
      #
      # [CarrierWave::Storage::Riak::File] the stored file
      #
      def store!(file)
        riak_options = {:content_type => file.content_type}
        f = CarrierWave::Storage::Riak::File.new(uploader, self, uploader.store_path)
        f.store(file.read, riak_options)
        f
      end

      # Do something to retrieve the file
      #
      # @param [String] identifier uniquely identifies the file
      #
      # [identifier (String)] uniquely identifies the file
      #
      # === Returns
      #
      # [CarrierWave::Storage::Riak::File] the stored file
      #
      def retrieve!(identifier)
        CarrierWave::Storage::Riak::File.new(uploader, self, uploader.store_path(identifier))
      end


    end # CloudFiles
  end # Storage
end # CarrierWave
