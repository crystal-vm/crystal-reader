# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = 'soml-parser'
  s.version = '0.5.0'

  s.authors = ['Torsten Ruger']
  s.email = 'torsten@villataika.fi'
  s.extra_rdoc_files = ['README.md']
  s.files = %w(README.md LICENSE) + Dir.glob("lib/**/*")
  s.homepage = 'https://github.com/salama/soml-parser'
  s.license = 'GNU v3'
  s.require_paths = ['lib']
  s.summary = 'Ruby parser for the salama object system language'

  s.add_dependency 'parslet', '~> 1.7.1'
  s.add_dependency 'ast', '~> 2.1.0'

end
