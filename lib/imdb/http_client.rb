require 'net/http'

module Imdb
  class HttpClient

    HEADERS = {
      'Accept-Language' => 'en-US,en;q=0.5',
    }

    def self.fetch(url)
      uri = URI(url)
      Net::HTTP.get(uri)
    end
  end
end
