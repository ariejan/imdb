$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

require 'open-uri'
require 'net/http'
require 'rubygems'
require 'hpricot'

require 'imdb/config'
require 'imdb/movie'
require 'imdb/movie_list'
require 'imdb/search'
require 'imdb/top_250'
require 'imdb/string_extensions'

module Imdb
  VERSION = File.open(File.join(File.dirname(__FILE__), '..', 'VERSION'), 'r') { |f| f.read.strip }
end
