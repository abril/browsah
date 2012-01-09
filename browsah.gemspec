# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)

require "browsah"

gf = File.expand_path("../GEM_VERSION", __FILE__)
File.delete(gf) if File.exists?(gf)

Gem::Specification.new do |s|
  s.name          = "browsah"
  s.version       = Browsah::VERSION.to_s
  s.platform      = Gem::Platform::RUBY
  s.summary       = "it's a real browsah"
  s.require_paths = ['lib']
  s.files         = Dir["{lib/**/*.rb,GEM_VERSION,README.md}"]

  s.author        = "Abril"
  s.email         = "lfcipriani@gmail.com"
  s.homepage      = "http://engineering.abril.com.br/"

  s.add_dependency "em-http-request", "~> 1.0.0"
  s.add_dependency "em-synchrony", "~> 1.0.0"

  s.add_development_dependency "webmock"
  s.add_development_dependency "minitest", "~> 2.10.0"
  s.add_development_dependency "ruby-debug19"
  s.add_development_dependency "step-up", "~> 0.7.0"
end
