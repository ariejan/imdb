module Imdb
  class Episode < Base
    attr_accessor :season, :episode, :episode_title

    def initialize(imdb_id, season, episode, episode_title, options = {})
      super(imdb_id, episode_title, options)
      @url = "http://akas.imdb.com/title/tt#{imdb_id}/combined"
      @season = season
      @episode = episode
    end

    # Return the original air date for this episode
    def air_date
      document.at("h5[text()*='Original Air Date'] ~ div").content.strip.split("\n").first.strip rescue nil
    end

    private

    def document
      @document ||= Nokogiri::HTML(client.get(@url))
    end
  end
end
