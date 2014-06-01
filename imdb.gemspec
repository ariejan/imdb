# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'imdb/version'

Gem::Specification.new do |spec|
  spec.name        = "imdb"
  spec.version     = Imdb::VERSION
  spec.authors     = ["Ariejan de Vroom"]
  spec.email       = ["ariejan@ariejan.net"]
  spec.homepage    = "http://github.com/ariejan/imdb"
  spec.summary     = %q{Easily access the publicly available information on IMDB.}
  spec.description = %q{Easily use Ruby or the command line to find information on IMDB.com.}

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'nokogiri', '= 1.6.2.1'

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "minitest"
  spec.add_development_dependency "vcr"
end
