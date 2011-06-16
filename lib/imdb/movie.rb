module Imdb
  
  # Represents a Movie on IMDB.com
  class Movie
    attr_accessor :id, :url, :title
    
    # Initialize a new IMDB movie object with it's IMDB id (as a String)
    #
    #   movie = Imdb::Movie.new("0095016")
    #
    # Imdb::Movie objects are lazy loading, meaning that no HTTP request
    # will be performed when a new object is created. Only when you use an 
    # accessor that needs the remote data, a HTTP request is made (once).
    #
    def initialize(imdb_id, attributes={})
      @id = imdb_id
      @url = "http://www.imdb.com/title/tt#{imdb_id}/"
      attributes={:title => attributes} if attributes.kind_of?(String)
      @attributes=attributes
      @attributes[:title] = @attributes[:title].gsub(/"/, "") if @attributes[:title]
    end
    
    def reload
      @attributes={}
      @document=nil
      self
    end
    
    # Returns an array with cast members
    def cast_members
      document.search("table.cast_list td.name a").map { |link| link.innerHTML.strip.imdb_unescape_html } rescue []
    end
    
    def cast_member_ids
      document.search("table.cast_list td.name a").map {|l| l['href'].sub(%r{^/name/(.*)/}, '\1') }
    end
    
    # Returns the name of the director
    def director
      # document.at("h4[text()='Director:'] ~ a").innerHTML.strip.imdb_unescape_html rescue nil
      document.search("h4[text()^='Director'] ~ a").map { |link| link.innerHTML.strip.imdb_unescape_html } rescue []
    end
    
    # Returns an array of genres (as strings)
    def genres
      document.search("h4[text()='Genres:'] ~ a[@href*='/genre/']").map { |link| link.innerHTML.strip.imdb_unescape_html } rescue []
    end

    # Returns an array of languages as strings.
    def languages
      document.search("h4[text()='Language:'] ~ a[@href*='/language/']").map { |link| link.innerHTML.strip.imdb_unescape_html } rescue []
    end
    
    # Returns the duration of the movie in minutes as an integer.
    def length
      document.search("//h4[text()^='Runtime']/..").innerHTML[/\d+ min/].to_i rescue nil
    end
    
    # Returns a string containing the plot.
    def plot
      sanitize_plot(document.search("div.star-box ~ p")[1].innerHTML.strip) rescue nil
    end
    
    # Returns a string containing the URL to the movie poster.
    def poster
      src = document.at("td#img_primary a img")['src'] rescue nil
      case src
      when /^(http:.+@@)/
        $1 + '.jpg'
      when /^(http:.+?)\.[^\/]+$/
        $1 + '.jpg'
      end
    end
    
    # Returns a float containing the average user rating
    def rating
      document.at(".rating-rating").innerHTML.strip.imdb_unescape_html.split('/').first.to_f rescue nil
    end
    
    # Returns a string containing the tagline
    def tagline
      document.search("h4[text()='Taglines:']").first.next_node.to_s.strip.imdb_unescape_html rescue nil
    end
    
    # Returns a string containing the mpaa rating and reason for rating
    def mpaa_rating
      document.search("h4[text()*='Motion Picture Rating']").first.next_node.to_s.strip.imdb_unescape_html rescue nil
    end
    
    # Returns a string containing the title
    def title
      @attributes[:title] ||= (document.at("h1").innerHTML.split('<span').first.strip.imdb_unescape_html rescue nil)
    end
    
    # Returns an integer containing the year (CCYY) the movie was released in.
    def year
      @attributes[:year] ||= (document.search('a[@href^="/year/"]').innerHTML.to_i rescue nil)
    end
    
    # Returns release date for the movie.
    def release_date
      sanitize_release_date(document.search("h4[text()*='Release Date']").first.next_node.to_s) rescue nil
    end

    private
    
    # Returns a new Hpricot document for parsing.
    def document
      @document ||= Hpricot(Imdb::Movie.find_by_id(@id))
    end
    
    # Use HTTParty to fetch the raw HTML for this movie.
    def self.find_by_id(imdb_id)
      open("http://www.imdb.com/title/tt#{imdb_id}/")
    end
    
    # Convenience method for search
    def self.search(query)
      Imdb::Search.new(query).movies
    end

    def self.top_250
      Imdb::Top250.new.movies
    end
    
    def sanitize_plot(the_plot)
      the_plot = the_plot.gsub(/<a\s+href="plotsummary">.+<\/.+>/, '')
      the_plot = the_plot.imdb_strip_tags                                  

      the_plot = the_plot.gsub(/&nbsp;&raquo;$/i, "")
      the_plot = the_plot.strip.imdb_unescape_html
    end
    
    def sanitize_release_date(date)
      date.strip.imdb_unescape_html.gsub("\n",' ')
    end
    
  end # Movie
  
end # Imdb
