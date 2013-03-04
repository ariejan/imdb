module Imdb
  class Season
    attr_accessor :id, :url, :season_number, :episodes

    def initialize(url)
      @url = url
      @season_number = @url.scan(/episodes\?season=(\d+)/).flatten.first.to_i
      @episodes = []
    end

    def episode(number)
      episodes.fetch(number-1, nil)
    end

    def episodes
      @episodes = []

      document.search("div.eplist a[@itemprop*='name']").each_with_index do |link, index|
        @episodes << Imdb::Episode.new(
          link[:href].scan(/\d+/).first,
          @season_number,
          index + 1,
          link.content.strip
        )
      end

      @episodes
    end

    private

    def document
      @document ||= Nokogiri::HTML(open(@url))
    end
  end
end
