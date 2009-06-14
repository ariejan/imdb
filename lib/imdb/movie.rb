module Imdb
  
  # Represents a Movie on IMDB.com
  class Movie
    include HTTParty
    
    attr_accessor :id, :url, :title
    
    # Initialize a new IMDB movie object with it's IMDB id (as a String)
    #
    #   movie = Imdb::Movie.new("0095016")
    #
    # Imdb::Movie objects are lazy loading, meaning that no HTTP request
    # will be performed when a new object is created. Only when you use an 
    # accessor that needs the remote data, a HTTP request is made (once).
    #
    def initialize(imdb_id, title = nil)
      @id = imdb_id
      @url = "http://www.imdb.com/title/tt#{imdb_id}/"
      @title = title.gsub(/"/, "") if title
    end
    
    # Returns an array with cast members
    def cast_members
      document.search("table.cast td.nm a").map { |link| link.innerHTML.strip.imdb_unescape_html } rescue []
    end
    
    # Returns the name of the director
    def director
      # document.at("h5[text()='Director:'] ~ a").innerHTML.strip.imdb_unescape_html rescue nil
      document.search("h5[text()^='Director'] ~ a").map { |link| link.innerHTML.strip.imdb_unescape_html } rescue []
    end
    
    # Returns an array of genres (as strings)
    def genres
      document.search("h5[text()='Genre:'] ~ a[@href*=/Sections/Genres/']").map { |link| link.innerHTML.strip.imdb_unescape_html } rescue []
    end
    
    # Returns the duration of the movie in minutes as an integer.
    def length
      document.search("//h5[text()^='Runtime']/..").innerHTML[/\d+ min/].to_i rescue nil
    end
    
    # Returns a string containing the plot.
    def plot
      document.search("//h5[text()^='Plot']/..").innerHTML.split("\n")[2].gsub(/<.+>.+<\/.+>/, '').strip.imdb_unescape_html rescue nil
    end
    
    # Returns a string containing the URL to the movie poster.
    def poster
      document.at("a[@name='poster'] img")['src'][/http:.+@@/] + '.jpg' rescue nil
    end
    
    # Returns a float containing the average user rating
    def rating
      document.at(".general.rating b").innerHTML.strip.imdb_unescape_html.split('/').first.to_f rescue nil
    end
    
    # Returns a string containing the tagline
    def tagline
      document.search("//h5[text()^='Tagline']/..").innerHTML.split("\n")[2].gsub(/<.+>.+<\/.+>/, '').strip.imdb_unescape_html rescue nil
    end
    
    # Returns a string containing the title
    def title(force_refresh = false)
      if @title && !force_refresh
        @title
      else
        @title = document.at("h1").innerHTML.split('<span').first.strip.imdb_unescape_html rescue nil 
      end
    end
    
    # Returns an integer containing the year (CCYY) the movie was released in.
    def year
      document.search('a[@href^="/Sections/Years/"]').innerHTML.to_i
    end
        
    private
    
    # Returns a new Hpricot document for parsing.
    def document
      @document ||= Hpricot(Imdb::Movie.find_by_id(@id))
    end
    
    # Use HTTParty to fetch the raw HTML for this movie.
    def self.find_by_id(imdb_id)
      get("http://www.imdb.com/title/tt#{imdb_id}/")
    end
    
    # Convenience method for search
    def self.search(query)
      Imdb::Search.new(query)
    end
    
  end # Movie
  
end # Imdb
