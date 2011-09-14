require 'bundler'
Bundler::GemHelper.install_tasks

load File.expand_path(File.dirname(__FILE__) + "/tasks/fixtures.rake")

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

task :default => :spec

require 'imdb/version'
require 'hanna/rdoctask'
Rake::RDocTask.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "imdb #{Imdb::VERSION} documentation"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
  rdoc.options << '--webcvs=http://github.com/ariejan/imdb/tree/master/'
end

require 'gokdok'
Gokdok::Dokker.new do |gd|
  gd.repo_url = "git@github.com:ariejan/imdb.git"
  gd.doc_home = "rdoc"
  gd.remote_path = "."
end