module Imdb

  class MovieList
    def movies
      @movies ||= parse_movies
    end

    private
    def parse_movies
      document.search("a[@href^='/title/tt']").reject do |element|
        element.inner_html.imdb_strip_tags.empty? ||
        element.parent.inner_html =~ /media from/i
      end.map do |element|
        id = element['href'][/\d+/]

        data = element.parent.inner_html.split("<br />")
        title = (!data[0].nil? && !data[1].nil? && data[0] =~ /img/) ? data[1] : data[0]
        title = title.imdb_strip_tags.imdb_unescape_html
        title.gsub!(/\s+\(\d\d\d\d\)$/, '')

        alternative_titles = []

        if title =~ /\saka\s/
          titles = title.split(/\saka\s/)
          title = titles.shift.strip.imdb_unescape_html
        end

        [id, title]
      end.uniq.map do |values|
        Imdb::Movie.new(*values)
      end
    end
  end # MovieList

end # Imdb
