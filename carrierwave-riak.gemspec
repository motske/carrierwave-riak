# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)

Gem::Specification.new do |s|
  s.name        = "carrierwave-riak"
  s.version     = "0.1.0"
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Kevin Motschiedler"]
  s.email       = ["kdmotschiedler@gmail.com"]
  s.homepage    = "https://github.com/motske/carrierwave-riak"
  s.summary     = %q{Riak Storage support for CarrierWave}
  s.description = %q{Riak Storage support for CarrierWave}
  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_development_dependency "carrierwave"
  s.add_development_dependency "riak-client", ["~> 1.0.0"]
  s.add_development_dependency "rails", ["~> 3.0.5"]
  s.add_development_dependency "rspec", ["~> 2.6"]
  s.add_development_dependency "rake", ["~> 0.9"]
end