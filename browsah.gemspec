Gem::Specification.new do |s|
  s.name          = "browsah"
  s.version       = "0.0.0"
  s.platform      = Gem::Platform::RUBY
  s.summary       = "it's a real browsah"
  s.require_paths = ['lib']
  s.files         = Dir["{lib/**/*.rb,README.md,test/**/*.rb,Rakefile,*.gemspec,script/*}"]

  s.author        = "Abril"
  s.email         = "lfcipriani@gmail.com"
  s.homepage      = "http://abril.com"

  # s.add_dependency('dependency', '>= 1.0.0')

  # s.add_development_dependency('cover_me')
  # s.add_development_dependency('ruby-debug19')
end
