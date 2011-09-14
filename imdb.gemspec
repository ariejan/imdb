# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "imdb/version"

Gem::Specification.new do |s|
  s.name        = "imdb"
  s.version     = Imdb::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Ariejan de Vroom"]
  s.email       = ["ariejan@ariejan.net"]
  s.homepage    = "http://github.com/ariejan/imdb"
  s.summary     = %q{Easily access the publicly available information on IMDB.}
  s.description = %q{Easily use Ruby or the command line to find information on IMDB.com.}

  s.rubyforge_project = "imdb"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency 'hpricot', '~> 0.8.4'

  s.add_development_dependency 'rdoc'
  s.add_development_dependency 'rspec', '~> 1.3.2'
  s.add_development_dependency 'fakeweb'
end
