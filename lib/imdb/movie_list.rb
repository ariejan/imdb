module Imdb

  class MovieList
    attr_accessor :client

    def initialize(options = {})
      @client = options[:client] || Imdb::Client.new
    end

    def movies
      @movies ||= parse_movies
    end

    private
    def parse_movies
      document.search("a[@href^='/title/tt']").reject do |element|
        element.inner_html.imdb_strip_tags.empty? ||
        element.inner_html.imdb_strip_tags == "X" ||
        element.parent.inner_html =~ /media from/i
      end.map do |element|
        id = element['href'][/\d+/]

        title = element.text

        full_title = element.parent.text
        year = full_title.match(/\((\d{4})\)/)[1] || nil

        alternative_titles = []

        if title =~ /\saka\s/
          titles = title.split(/\saka\s/)
          title = titles.shift.strip.imdb_unescape_html
        end

        [id, title, year]
      end.uniq.map do |values|
        Imdb::Movie.new(*values)
      end
    end
  end # MovieList

end # Imdb
