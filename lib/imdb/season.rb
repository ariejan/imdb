module Imdb
  
  class Season
    attr_accessor :id, :url, :season_number, :episodes
    
    
    def initialize(url)
      @url = url
      @season_number = url[-1,1]
      @episodes = []
    end
    
    # Returns numbers of episode
    def episode_numbers
      document.search("div div[@class*=season-filter-all filter-season-#{season_number}'] div[@class*=filter-all]").size rescue nil
    end
    
    def episode(number = 1)
      Imdb::Episode.new(number, document.search("div div[@class*=season-filter-all filter-season-#{season_number}'] div[@class*=filter-all]")[number - 1], self)
    end
      
    def episodes
      if @episodes.empty?
        document.search("div div[@class*=season-filter-all filter-season-#{season_number}'] div[@class*=filter-all]").each_with_index do |node_episode, i|
          @episodes << Imdb::Episode.new(i + 1, node_episode, self)
        end
      end
      @episodes
    end
    
    private
    
    # Returns a new Hpricot document for parsing.
    def document
      @document ||= Hpricot(Imdb::Season.find_by_season(@url))
    end
    
    # Use HTTParty to fetch the raw HTML for this season
    def self.find_by_season(url)
      open(url)
    end
    
  end # Season
  
end # Imdb
