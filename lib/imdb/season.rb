module Imdb
  class Season
    attr_accessor :id, :url, :client, :season_number, :episodes

    def initialize(url, options = {})
      @client = options[:client] || Imdb::Client.new
      @url = url
      @season_number = @url.scan(/episodes\?season=(\d+)/).flatten.first.to_i
      @episodes = []
    end

    def episode(number)
      i = episodes.index{|ep| ep.episode == number}
      (i.nil? ? nil : episodes[i])
    end

    def episodes
      @episodes = []

      document.search("div.eplist div[@itemprop*='episode']").each do |div|
        link = div.search("a[@itemprop*='name']").first
        @episodes << Imdb::Episode.new(
          link[:href].scan(/\d+/).first,
          @season_number,
          div.search("meta[@itemprop*='episodeNumber']").first[:content].to_i,
          link.content.strip
        )
      end

      @episodes
    end

    private

    def document
      @document ||= Nokogiri::HTML(client.get(@url))
    end
  end
end
