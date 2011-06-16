module Imdb

  class Top250 < MovieList
    private
    def document
      @document ||= Hpricot(open("http://akas.imdb.com/chart/top"))
    end
  end # Top250

end # Imdb
