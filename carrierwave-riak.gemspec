# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require 'carrierwave/riak/version'

Gem::Specification.new do |s|
  s.name          = "carrierwave-riak"
  s.version       = CarrierWave::Riak::VERSION
  s.platform      = Gem::Platform::RUBY
  s.authors       = ["Kevin Motschiedler"]
  s.email         = ["kdmotschiedler@gmail.com"]
  s.homepage      = "https://github.com/motske/carrierwave-riak"
  s.summary       = %q{Riak Storage support for CarrierWave}
  s.description   = %q{Riak Storage support for CarrierWave}
  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency "carrierwave"
  s.add_dependency "riak-client", "~> 1.0"

  s.add_development_dependency "rails", "~> 3.0"
  s.add_development_dependency "rspec", "~> 2.13"
end
