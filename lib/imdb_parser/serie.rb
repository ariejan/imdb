module Imdb
  
  class Serie < ImdbBase
    
    # s = Imdb::Serie.new("0773262")
    # e = s.seasons.first.episodes.first
    def number_seasons
      document.search("a[@href*=episodes#season']").size
    end

    def season_urls
      document.search("a[@href*=episodes#season']").map { |link| url.gsub("combined","") + "episodes#season-" + link.innerHTML.strip.imdb_unescape_html } rescue []
    end
    
    def seasons
      s = []
      season_urls.each_with_index do |url|
        s << Imdb::Season.new(url)
      end
      s
    end
      
  end  #Serie
end # Imdb
