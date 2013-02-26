$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

require 'open-uri'
require 'rubygems'
require 'hpricot'

require 'imdb/base'
require 'imdb/movie'
require 'imdb/serie'
require 'imdb/movie_list'
require 'imdb/search'
require 'imdb/top_250'
require 'imdb/string_extensions'
require 'imdb/version'
