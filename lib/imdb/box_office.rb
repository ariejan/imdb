module Imdb
  class BoxOffice < MovieList
    private

    def document
      @document ||= Nokogiri::HTML(open('http://akas.imdb.com/boxoffice/'))
    end
  end # BoxOffice
end # Imdb
