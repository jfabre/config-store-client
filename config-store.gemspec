# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "#{lib}/config_store/version"

Gem::Specification.new do |gem|
  gem.name          = "config-store"
  gem.version       = ConfigStore::Version
  gem.authors       = ["Jeremy Fabre, Emanuel Petre"]
  gem.email         = ["jeremy.fabre@hotmail.com, petreemanuel@gmail.com"]
  gem.description   = "Config-store helps you manage your projects configs, so you can easily plug and reuse them." 
  gem.summary       = "Easy configs managements"
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
  
  gem.add_dependency 'activeresource'
  gem.add_dependency 'json'
  gem.add_dependency 'commander'
end
