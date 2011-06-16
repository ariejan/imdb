module Imdb
  
  # Search IMDB for a title
  class Search < MovieList
    attr_reader :query

    # Initialize a new IMDB search with the specified query
    #
    #   search = Imdb::Search.new("Star Trek")
    #
    # Imdb::Search is lazy loading, meaning that unless you access the +movies+ 
    # attribute, no query is made to IMDB.com.
    #
    def initialize(query)
      @query = query
    end
    
    # Returns an array of Imdb::Movie objects for easy search result yielded.
    # If the +query+ was an exact match, a single element array will be returned.
    def movies
      @movies ||= (exact_match? ? parse_movie : parse_movies)
    end
    
    private
    def document
      @document ||= Hpricot(Imdb::Search.query(@query))
    end
    
    def self.query(query)
      open("http://www.imdb.com/find?q=#{CGI::escape(query)};s=tt")
    end
    
    def parse_movie
      id = document.at("head/link[@rel='canonical']")['href'][/\d+/]
      [Imdb::Movie.new(id)]
    end
    
    # Returns true if the search yielded only one result, an exact match
    def exact_match?
      !document.at("div.star-box").nil?
    end
    
  end # Search
end # Imdb
