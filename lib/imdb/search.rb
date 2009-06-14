module Imdb
  
  # Search IMDB for a title
  class Search
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
    
    #private
    
    def document
      @document ||= Hpricot(Imdb::Search.query(@query))
    end
    
    def self.query(query)
      open("http://www.imdb.com/find?q=#{CGI::escape(query)};s=tt")
    end
    
    def parse_movies
      document.search('a[@href^="/title/tt"]').reject do |element|
        element.innerHTML.imdb_strip_tags.empty? ||
        element.parent.innerHTML =~ /media from/i
      end.map do |element|
        id = element['href'][/\d+/]
        
        data = element.parent.innerHTML.split("<br />")
        if !data[0].nil? && !data[1].nil? && data[0] =~ /img/
          title = data[1]
        else
          title = data[0]
        end
        
        title = title.imdb_strip_tags.imdb_unescape_html
        
        [id, title]
      end.uniq.map do |values|
        Imdb::Movie.new(*values)
      end
    end

    def parse_movie
      id = document.at("a[@name='poster']")['href'][/\d+$/]
      title = document.at("h1").innerHTML.split('<span').first.strip.imdb_unescape_html
      [Imdb::Movie.new(id, title)]
    end
    
    # Returns true if the search yielded only one result, an exact match
    def exact_match?
      !document.at("//h3[text()^='Overview']/..").nil?
    end
    
  end # Search
end # Imdb
