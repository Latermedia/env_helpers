# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'env_helpers/version'

Gem::Specification.new do |spec|
  spec.name          = 'env_helpers'
  spec.version       = EnvHelpers::VERSION
  spec.authors       = ['Les Fletcher']
  spec.email         = ['development@later.com']

  spec.summary       = 'A set of helpers to improve ENV functionality'
  spec.description   = 'Helpers for dealing with environment variables, with the option of adding the functionality to ENV. '
  spec.homepage      = 'https://github.com/Latermedia/env_helpers'
  spec.license       = 'MIT'

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.16'
  spec.add_development_dependency 'bundler-audit'
  spec.add_development_dependency 'climate_control', '~> 0.2'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rspec_junit_formatter', '~> 0.2'
  spec.add_development_dependency 'rubocop', '~> 0.60.0'
  spec.add_development_dependency 'yard'
end
