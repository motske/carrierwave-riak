# CarrierWave for [Riak](http://wiki.basho.com/Riak.html)

This gem adds storage support for [Riak](http://wiki.basho.com/Riak.html) to [CarrierWave](https://github.com/jnicklas/carrierwave/)

This module should work for basic uploads, but hasn't been tested with all features of carrierrwave and is very new.  The code was initially based
on [carrierwave-upyun](https://github.com/nowa/carrierwave-upyun) but also uses ideas taken from the built in Fog storage provider.

## Installation

    gem install carrierwave-riak

## Or using Bundler, in `Gemfile`

    gem 'riak-client'
    gem 'carrierwave-riak', :require => "carrierwave/riak"

## Configuration

You'll need to configure the Riak client in config/initializes/carrierwave.rb

```ruby
CarrierWave.configure do |config|
  config.storage = :riak
  config.riak_host = 'localhost'
  config.riak_port = 8098
end
```

## Usage example

Note that for your uploader, your should extend the CarrierWave::Uploader::Riak class.

```ruby
class DocumentUploader < CarrierWave::Uploader::Riak

    # If key method is not defined, Riak generated keys will be used and returned as the identifier

    def key
        original_filename
    end

    def bucket
      "my_bucket"
    end
end
```

### Using Riak generated keys ###

Because the orm record is saved before the storage object is, the orm record needs to be updated after
saving to storage if a Riak generated key is to be used as the identifier.  The CarrierWave::Uploader::Riak
class defines an :after callback to facilitate this.  This only works for ActiveRecord and is likely pretty
hacky.  Maybe someone can suggest a better way to deal with this.

## TODO ###

- Write specs.  Bad programmer.

## Contributing ##

If this is helpful to you, but isn't quite working please send me pull requests.