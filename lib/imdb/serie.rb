module Imdb
  
  class Serie < ImdbBase
    
    def number_seasons
      document.search("a[@href*=episodes#season']").size
    end

    def season_urls
      document.search("a[@href*=episodes#season']").map { |link| url.gsub("combined","") + "episodes#season-" + link.innerHTML.strip.imdb_unescape_html } rescue []
    end
      
  end  #Serie
end # Imdb
