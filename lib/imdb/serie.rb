module Imdb

  # Represents a TV series on IMDB.com
  class Serie < Base

    def season(number)
      seasons.fetch(number-1, nil)
    end

    def seasons
      season_urls.map { |url| Imdb::Season.new(url) }
    end

    private

    def season_urls
      document.search("h5[text()='Seasons:'] ~ div a[@href*='episodes?season']")
        .map { |link| url.gsub("combined","") + "episodes?season=" + link.content.strip } rescue []
    end
  end # Serie

end # Imdb
