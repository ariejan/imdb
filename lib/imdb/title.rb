module Imdb
  class Title < Hashie::Mash

    def self.fetch(id)
      Imdb::Title.new(id)
    end

    private

    def initialize(id)
      @id = id
      process_imdb_data
    end

    def process_imdb_data
      self.title = rinse(document.at('h1'))
      self.year  = rinse(document.at('h1/span/a'))
    end

    def rinse(data)
      data.children.first.text.strip
    end

    def document
      @document ||= Nokogiri::HTML(fetch_remote_data)
    end

    def fetch_remote_data
      Imdb::HttpClient.fetch(title_url)
    end

    def title_url
      "http://akas.imdb.com/title/tt#{@id}/combined"
    end

  end
end
