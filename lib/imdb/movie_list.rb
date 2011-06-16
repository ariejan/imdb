module Imdb

  class MovieList
    def movies
      @movies ||= parse_movies
    end
    
    private
    def parse_movies
      document.search('a[@href^="/title/tt"]').map do |element|
        id = element['href'][/\d+/]
        title = element.innerHTML.imdb_unescape_html
        [id, title]
      end.uniq.map do |values|
        Imdb::Movie.new(*values)
      end
    end
  end # MovieList

end # Imdb
