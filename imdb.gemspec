# -*- encoding: utf-8 -*-
$LOAD_PATH.push File.expand_path('../lib', __FILE__)
require 'imdb/version'

Gem::Specification.new do |s|
  s.name        = 'imdb'
  s.version     = Imdb::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ['Ariejan de Vroom']
  s.email       = ['ariejan@ariejan.net']
  s.homepage    = 'http://github.com/ariejan/imdb'
  s.summary     = %q(Easily access the publicly available information on IMDB.)
  s.description = %q(Easily use Ruby or the command line to find information on IMDB.com.)

  s.rubyforge_project = 'imdb'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map { |f| File.basename(f) }
  s.require_paths = ['lib']

  s.add_dependency 'nokogiri', '= 1.6.2.1'

  s.add_development_dependency 'rake', '~> 10.0.3'
  s.add_development_dependency 'rspec', '~> 2.13.0'
  s.add_development_dependency 'gokdok'
  s.add_development_dependency 'rdoc', '~> 4.0'
  s.add_development_dependency 'fakeweb'

end
