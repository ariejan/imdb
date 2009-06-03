%w[rubygems rake rake/clean fileutils newgem rubigen].each { |f| require f }
require File.dirname(__FILE__) + '/lib/imdb'

# Generate all the Rake tasks
# Run 'rake -T' to see list of generated tasks (from gem root directory)
$hoe = Hoe.new('imdb', Imdb::VERSION) do |p|
  p.developer('Ariejan de Vroom', 'ariejan@ariejan.net')
  p.changes              = p.paragraphs_of("History.txt", 0..1).join("\n\n")
  p.rubyforge_name       = 'imdb'
  p.extra_deps         = [
    ['httparty','>= 0.4.3'],
    ['hpricot', '>= 0.8.1']
  ]
  p.extra_dev_deps = [
    ['newgem', ">= #{::Newgem::VERSION}"]
  ]
  
  p.clean_globs |= %w[**/.DS_Store tmp *.log]
  path = (p.rubyforge_name == p.name) ? p.rubyforge_name : "\#{p.rubyforge_name}/\#{p.name}"
  p.remote_rdoc_dir = 'clown'
  p.rsync_args = '-av --delete --ignore-errors'
end

require 'newgem/tasks' # load /tasks/*.rake
Dir['tasks/**/*.rake'].each { |t| load t }

# TODO - want other tests/tasks run by default? Add them to the list
# task :default => [:spec, :features]

remove_task :publish_docs

desc 'Publish RDoc to RubyForge.'
task :publish_docs => [:clean, :docs] do
  local_dir = 'doc'
  host = website_config["host"]
  host = host ? "#{host}:" : ""
  remote_dir = File.join(website_config["remote_dir"], "")
  sh %{rsync -aCv #{local_dir}/ #{host}#{remote_dir}}
end
