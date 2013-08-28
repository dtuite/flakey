# -*- encoding: utf-8 -*-
require File.expand_path('../lib/flakey/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["David Tuite"]
  gem.email         = ["dtuite@gmail.com"]
  gem.description   = %q{Social helpers for Rails apps.}
  gem.summary       = %q{Makes a bunch of helper methods available for including in your Rails views.}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "flakey"
  gem.require_paths = ["lib"]
  gem.version       = Flakey::VERSION

  gem.add_dependency 'activesupport'

  # Pretend we're in Rails.
  gem.add_development_dependency 'actionpack'

  gem.add_development_dependency 'rspec'
  gem.add_development_dependency 'rake'
end
