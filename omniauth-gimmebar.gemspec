# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'omniauth-gimmebar/version'

Gem::Specification.new do |gem|
  gem.authors       = ["Greg Signal"]
  gem.email         = ["greg.signal@gmail.com"]
  gem.description   = %q{Omniauth strategy for Gimmebar}
  gem.summary       = %q{Omniauth strategy for Gimmebar}
  gem.homepage      = "https://github.com/glsignal/omniauth-gimmebar"

  gem.name          = "omniauth-gimmebar"
  gem.version       = OmniAuth::Gimmebar::VERSION

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency 'multi_json', '~>1.0'
  gem.add_dependency 'omniauth', '~> 1.0'
  gem.add_dependency 'omniauth-oauth2', '~> 1.1'
  gem.add_development_dependency 'rspec', '~> 2.7'
  gem.add_development_dependency 'rack-test'
  gem.add_development_dependency 'rest-client'
  gem.add_development_dependency 'simplecov'
  gem.add_development_dependency 'webmock'
end
