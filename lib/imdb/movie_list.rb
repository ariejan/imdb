module Imdb

  class MovieList
    def movies
      @movies ||= parse_movies
    end
    
    private
    def parse_movies
      document.search('a[@href^="/title/tt"]').reject do |element|
        element.innerHTML =~ /^<img/ ||
        element.innerHTML =~ /^tt\d+/
      end.map do |element|
        id = element['href'][/\d+/]
        title = element.innerHTML.imdb_unescape_html
        year = (element.next_node.to_s.match(/\d+/)[0].to_i rescue nil)
        [id, {:title => title,:year => year}]
      end.uniq.map do |values|
        Imdb::Movie.new(*values)
      end
    end
  end # MovieList

end # Imdb
