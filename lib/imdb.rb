require 'nokogiri'
require 'hashie'

require "imdb/http_client"
require "imdb/title"
require "imdb/version"

module Imdb

  # Fetches a title from IMDB, this can be a movie
  # or TV series.
  #
  # To fetch Total Recall, use like this:
  #
  #     Imdb.fetch_title("0100802")
  #
  def self.fetch_title(id)
    Imdb::Title.fetch(id)
  end
end
