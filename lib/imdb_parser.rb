$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

require 'open-uri'
require 'rubygems'
require 'hpricot'

require 'imdb_parser/imdb_base'
require 'imdb_parser/episode'
require 'imdb_parser/season'
require 'imdb_parser/movie'
require 'imdb_parser/serie'
require 'imdb_parser/movie_list'
require 'imdb_parser/search'
require 'imdb_parser/top_250'
require 'imdb_parser/string_extensions'
require 'imdb_parser/version'
