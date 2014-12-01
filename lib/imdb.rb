$LOAD_PATH.unshift(File.dirname(__FILE__)) unless
  $LOAD_PATH.include?(File.dirname(__FILE__)) || $LOAD_PATH.include?(File.expand_path(File.dirname(__FILE__)))

require 'open-uri'
require 'rubygems'
require 'nokogiri'

require 'imdb/base'
require 'imdb/movie'
require 'imdb/award'
require 'imdb/serie'
require 'imdb/season'
require 'imdb/episode'
require 'imdb/movie_list'
require 'imdb/search'
require 'imdb/top_250'
require 'imdb/string_extensions'
require 'imdb/version'
