$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

require 'rubygems'
require 'httparty'
require 'hpricot'

require 'imdb/movie'
require 'imdb/search'
require 'imdb/string_extensions'

module Imdb
  VERSION = '0.0.2'
end