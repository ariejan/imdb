require 'rubygems'
require 'rake'
load File.expand_path(File.dirname(__FILE__) + "/tasks/fixtures.rake")

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "imdb"
    gem.summary = %Q{Easily access the publicly available information on IMDB.}
    gem.description = %Q{Easily use Ruby or the command line to find information on IMDB.com.}
    gem.email = "ariejan@ariejan.net"
    gem.homepage = "http://github.com/ariejan/imdb"
    gem.authors = ["Ariejan de Vroom"]
    gem.add_development_dependency "rspec"
    
    # Dependencies
    gem.add_dependency('hpricot', '>= 0.8.1')
    
    # Development dependencies
    gem.add_development_dependency('fakeweb')
    gem.add_development_dependency('rspec')
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: sudo gem install jeweler"
end

require 'spec/rake/spectask'
Spec::Rake::SpecTask.new(:spec) do |spec|
  spec.libs << 'lib' << 'spec'
  spec.spec_files = FileList['spec/**/*_spec.rb']
end

Spec::Rake::SpecTask.new(:rcov) do |spec|
  spec.libs << 'lib' << 'spec'
  spec.pattern = 'spec/**/*_spec.rb'
  spec.rcov = true
end

task :spec => :check_dependencies

task :default => :spec

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  if File.exist?('VERSION')
    version = File.read('VERSION')
  else
    version = ""
  end

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "imdb #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
