# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "#{lib}/config_store"

Gem::Specification.new do |gem|
  gem.name          = "config-store"
  gem.version       = ConfigStore::VERSION
  gem.authors       = ["Jeremy Fabre, Emanuel Petre"]
  gem.email         = ["jeremy.fabre@hotmail.com, petreemanuel@gmail.com"]
  gem.description   = %q{TODO: Write a gem description}
  gem.summary       = %q{TODO: Write a gem summary}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
  
  gem.add_dependency 'activeresource'
  gem.add_dependency 'json'
  gem.add_dependency 'commander'
end
