module Imdb
  
  class Movie
    include HTTParty
    
    attr_accessor :id, :url
    
    # Initialize a new IMDB movie object.
    def initialize(imdb_id)
      @id = imdb_id
      @url = "http://www.imdb.com/title/tt#{imdb_id}/"
    end
    
    def cast_members
      document.search("table.cast td.nm a").map { |link| link.innerHTML.strip.imdb_unescape_html } rescue []
    end
    
    def director
      document.at("h5[text()='Director:'] ~ a").innerHTML.strip.imdb_unescape_html rescue nil
    end
    
    def genres
      document.search("h5[text()='Genre:'] ~ a[@href*=/Sections/Genres/']").map { |link| link.innerHTML.strip.imdb_unescape_html } rescue []
    end
    
    def length
      document.search("//h5[text()^='Runtime']/..").innerHTML[/\d+ min/].to_i rescue nil
    end
    
    def plot
      document.search("//h5[text()^='Plot']/..").innerHTML.split("\n")[2].gsub(/<.+>.+<\/.+>/, '').strip.imdb_unescape_html rescue nil
    end
    
    def poster
      document.at("a[@name='poster'] img")['src'][/http:.+@@/] + '.jpg' rescue nil
    end
    
    def rating
      document.at(".general.rating b").innerHTML.strip.imdb_unescape_html.split('/').first.to_f rescue nil
    end
    
    def tagline
      document.search("//h5[text()^='Tagline']/..").innerHTML.split("\n")[2].gsub(/<.+>.+<\/.+>/, '').strip.imdb_unescape_html rescue nil
    end
    
    def title
      document.at("h1").innerHTML.split('<span').first.strip.imdb_unescape_html rescue nil 
    end
    
    def year
      document.search('a[@href^="/Sections/Years/"]').innerHTML.to_i
    end
        
    private
    
    def document
      @document ||= Hpricot(Imdb::Movie.find_by_id(@id))
    end
    
    def self.find_by_id(imdb_id)
      get("http://www.imdb.com/title/tt#{imdb_id}/")
    end
    
  end # Movie
  
end # Imdb