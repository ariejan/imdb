namespace :fixtures do
  desc "Refresh spec fixtures with fresh data from IMDB.com"
  task :refresh do
    require File.expand_path(File.dirname(__FILE__) + "/../spec/spec_helper")

    ONLY = ENV['ONLY'] ? ENV['ONLY'].split(',') : []
    IMDB_SAMPLES.each_pair do |url, fixture|
      next if !ONLY.empty? and !ONLY.include?(fixture)
      page = `curl -is #{url}`
      
      File.open(File.expand_path(File.dirname(__FILE__) + "/../spec/fixtures/#{fixture}"), 'w') do |f|
        f.write(page)
      end
      
    end
  end
end
