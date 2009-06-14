begin
  require 'spec'
rescue LoadError
  require 'rubygems'
  gem 'rspec'
  require 'spec'
end

$:.unshift(File.dirname(__FILE__) + '/../lib')
require 'imdb'

def read_fixture(path)
  File.read(File.expand_path(File.join(File.dirname(__FILE__), "fixtures", path)))
end

unless ENV['LIVE_TEST']
  begin
    require 'rubygems'
    require 'fakeweb'
    
    FakeWeb.allow_net_connect = false
    { "http://www.imdb.com:80/find?q=Matrix+Revolutions;s=tt" => "search_matrix_revolutions",
      "http://www.imdb.com:80/find?q=Star+Trek;s=tt" => "search_star_trek",
      "http://www.imdb.com:80/title/tt0117731/" => "tt0117731",
      "http://www.imdb.com:80/title/tt0095016/" => "tt0095016",
      "http://www.imdb.com:80/title/tt0242653/" => "tt0242653",
      "http://www.imdb.com:80/title/tt0242653/?fr=c2M9MXxsbT01MDB8ZmI9dXx0dD0xfG14PTIwfHFzPU1hdHJpeCBSZXZvbHV0aW9uc3xodG1sPTF8c2l0ZT1kZnxxPU1hdHJpeCBSZXZvbHV0aW9uc3xwbj0w;fc=1;ft=20" => "tt0242653",
    }.each do |url, response|
      FakeWeb.register_uri(:get, url, :response => read_fixture(response))
    end
  rescue LoadError
    puts "Could not load FakeWeb, these tests will hit IMDB.com"
    puts "You can run `gem install fakeweb` to stub out the responses."
  end
end
