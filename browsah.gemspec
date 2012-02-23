# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)

require 'browsah/version'

Gem::Specification.new do |s|
  s.name          = 'browsah'
  s.version       = Browsah::VERSION
  s.platform      = Gem::Platform::RUBY
  s.summary       = 'HTTP client and Hypermedia browser'
  s.require_paths = ['lib']
  s.files         = Dir['{lib/**/*.rb, README.md}']

  s.authors       = 'Abril'
  s.email         = 'lfcipriani@gmail.com'
  s.homepage      = 'http://engineering.abril.com.br'

  s.add_dependency 'em-http-request', '~> 1.0.0'
  s.add_dependency 'em-synchrony', '~> 1.0.0'

  s.add_development_dependency 'webmock'
  s.add_development_dependency 'minitest'
  s.add_development_dependency 'ruby-debug19'
  s.add_development_dependency 'step-up', '~> 0.7.0'
end
