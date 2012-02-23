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
  s.files         = Dir['{lib/**/*.rb, README.md, LICENSE}']

  s.authors       = 'Abril'
  s.email         = 'lfcipriani@gmail.com'
  s.homepage      = 'http://engineering.abril.com.br'

  s.add_dependency 'em-http-request', '~> 1.0.0'
  s.add_dependency 'em-synchrony', '~> 1.0.0'

  s.add_development_dependency 'rake'
  s.add_development_dependency 'webmock', '~> 1.8.0'
  s.add_development_dependency 'minitest', '~> 2.11.2'
  s.add_development_dependency 'step-up', '~> 0.8.0'
end
