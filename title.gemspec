# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'title/version'

Gem::Specification.new do |spec|
  spec.name          = 'title'
  spec.version       = Title::VERSION
  spec.authors       = ['Caleb Hearth']
  spec.email         = ['caleb@calebhearth.com']
  spec.summary       = 'I18n your <title>s'
  spec.description   = 'Abuses I18n to set HTML <title>s'
  spec.homepage      = 'https://github.com/calebhearth/title'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($/)
  spec.test_files    = spec.files.grep(%r{^spec/})
  spec.require_paths = ['lib', 'app']

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'coveralls'

  spec.add_dependency 'rails', '>= 3.1'
  spec.add_dependency 'i18n'
end
