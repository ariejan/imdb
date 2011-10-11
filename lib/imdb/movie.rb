module Imdb
  
  # Represents a Movie on IMDB.com
  class Movie < ImdbBase
    
    def trailers
      document.search("a[@href*='/video/screenplay/']").map { |link| "http://akas.imdb.com" + link.get_attribute("href") } rescue []
    end
    
    
  end # Movie
  
end # Imdb
