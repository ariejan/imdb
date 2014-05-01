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

        year_match = full_title.match(/\((\d{4})\)/)
        year = (year_match && year_match.length == 2) ? year_match[1] : nil

        poster_element = element.parent.parent.css('td.primary_photo a img').first
        poster = poster_element ? Base.format_poster_url(poster_element.attr(:src)) : nil

        alternative_titles = []

        if title =~ /\saka\s/
          titles = title.split(/\saka\s/)
          title = titles.shift.strip.imdb_unescape_html
        end

        movie_data = {}
        movie_data[:id] = id
        movie_data[:title] = title if title
        movie_data[:year] = year if year
        movie_data[:poster] = poster if poster
        movie_data[:client] = client

        movie_data
      end.uniq.map do |movie_data|
        Imdb::Movie.new(movie_data[:id], movie_data)
      end
    end
  end # MovieList

end # Imdb
