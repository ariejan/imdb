module Imdb
  # Search IMDB for a title
  class Search < MovieList
    TYPES = {
      :movie     => 'ft',
      :tv        => 'tv',
      :episode   => 'ep',
      :videogame => 'vg',
    }

    attr_reader :query
    attr_reader :type

    # Initialize a new IMDB search with the specified query
    #
    #   search = Imdb::Search.new("Star Trek")
    #
    # Imdb::Search is lazy loading, meaning that unless you access the +movies+
    # attribute, no query is made to IMDB.com.
    #
    def initialize(query, type = nil)
      @query = query
      @type  = type
    end

    # Returns an array of Imdb::Movie objects for easy search result yielded.
    # If the +query+ was an exact match, a single element array will be returned.
    def movies
      @movies ||= (exact_match? ? parse_movie : parse_movies)
    end

    private

    def document
      @document ||= Nokogiri::HTML(submit_query)
    end

    def submit_query
      url = "http://akas.imdb.com/find?q=#{CGI.escape(query)}&s=tt"
      url << "&ttype=#{TYPES[type]}" if type && TYPES.include?(type)
      open(url)
    end

    def parse_movie
      id    = document.at("head/link[@rel='canonical']")['href'][/\d+/]
      title = document.at('h1').inner_html.split('<span').first.strip.imdb_unescape_html

      [Imdb::Movie.new(id, title)]
    end

    # Returns true if the search yielded only one result, an exact match
    def exact_match?
      !document.at("table[@id='title-overview-widget-layout']").nil?
    end
  end # Search
end # Imdb
