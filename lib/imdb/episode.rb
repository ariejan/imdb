module Imdb
  class Episode < Base
    attr_accessor :season, :episode, :episode_title

    def initialize(imdb_id, season, episode, episode_title)
      super(imdb_id, episode_title)
      @season = season
      @episode = episode
    end

  end
end
