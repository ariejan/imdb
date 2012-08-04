module Imdb

  # Represents a Movie on IMDB.com
  class Movie
    attr_accessor :id, :url, :title, :also_known_as

    # Initialize a new IMDB movie object with it's IMDB id (as a String)
    #
    #   movie = Imdb::Movie.new("0095016")
    #
    # Imdb::Movie objects are lazy loading, meaning that no HTTP request
    # will be performed when a new object is created. Only when you use an
    # accessor that needs the remote data, a HTTP request is made (once).
    #
    def initialize(imdb_id, title = nil, also_known_as = [])
      @id = imdb_id
      @url = "http://akas.imdb.com/title/tt#{imdb_id}/combined"
      @title = title.gsub(/"/, "") if title
      @also_known_as = also_known_as
    end

    # Returns an array with cast members
    def cast_members
      document.search("table.cast td.nm a").map { |link| link.innerHTML.strip.imdb_unescape_html } rescue []
    end

    def cast_member_ids
      document.search("table.cast td.nm a").map {|l| l['href'].sub(%r{^/name/(.*)/}, '\1') }
    end

    # Returns an array with cast characters
    def cast_characters
      document.search("table.cast td.char").map { |link| link.innerText } rescue []
    end

    # Returns an array with cast members and characters
    def cast_members_characters(sep = '=>')
      memb_char = Array.new
      i = 0
      self.cast_members.each{|m|
        memb_char[i] = "#{self.cast_members[i]} #{sep} #{self.cast_characters[i]}"
        i=i+1
      }
      return memb_char
    end

    # Returns the name of the director
    def director
      document.search("h5[text()^='Director'] ~ a").map { |link| link.innerHTML.strip.imdb_unescape_html } rescue []
    end

    # Returns the url to the "Watch a trailer" page
    def trailer_url
      'http://imdb.com' + document.at("a[@href*=/video/screenplay/]")["href"] rescue nil
    end

    # Returns an array of genres (as strings)
    def genres
      document.search("h5[text()='Genre:'] ~ a[@href*=/Sections/Genres/']").map { |link| link.innerHTML.strip.imdb_unescape_html } rescue []
    end

    # Returns an array of languages as strings.
    def languages
      document.search("h5[text()='Language:'] ~ a[@href*=/language/']").map { |link| link.innerHTML.strip.imdb_unescape_html } rescue []
    end

    # Returns an array of countries as strings.
    def countries
      document.search("h5[text()='Country:'] ~ a[@href*=/country/']").map { |link| link.innerHTML.strip.imdb_unescape_html } rescue []
    end

    # Returns the duration of the movie in minutes as an integer.
    def length
      document.search("//h5[text()='Runtime:']/..").innerHTML[/\d+ min/].to_i rescue nil
    end

    # Returns a string containing the plot.
    def plot
      sanitize_plot(document.search("h5[text()='Plot:'] ~ div").first.innerHTML) rescue nil
    end

    # Returns a string containing the plot summary
    def plot_synopsis
      doc = Hpricot(Imdb::Movie.find_by_id(@id, :synopsis))
      doc.search("div[@id='swiki.2.1']").innerHTML.strip.imdb_unescape_html.imdb_strip_tags rescue nil
    end

    def plot_summary
      doc = Hpricot(Imdb::Movie.find_by_id(@id, :plotsummary))
      doc.search("p[@class='plotpar']").first.innerHTML.gsub(/<i.*/im, '').strip.imdb_unescape_html rescue nil
    end

    # Returns a string containing the URL to the movie poster.
    def poster
      src = document.at("a[@name='poster'] img")['src'] rescue nil
      case src
      when /^(http:.+@@)/
        $1 + '.jpg'
      when /^(http:.+?)\.[^\/]+$/
        $1 + '.jpg'
      end
    end

    # Returns a float containing the average user rating
    def rating
      document.at(".starbar-meta b").innerHTML.strip.imdb_unescape_html.split('/').first.to_f rescue nil
    end

    # Returns an int containing the number of user ratings
    def votes
      document.at("#tn15rating .tn15more").innerHTML.strip.imdb_unescape_html.gsub(/[^\d+]/, "").to_i rescue nil
    end

    # Returns a string containing the tagline
    def tagline
      document.search("h5[text()='Tagline:'] ~ div").first.innerHTML.gsub(/<.+>.+<\/.+>/, '').strip.imdb_unescape_html rescue nil
    end

    # Returns a string containing the mpaa rating and reason for rating
    def mpaa_rating
      document.search("h5[text()='MPAA:'] ~ div").first.innerHTML.strip.imdb_unescape_html rescue nil
    end

    # Returns a string containing the title
    def title(force_refresh = false)
      if @title && !force_refresh
        @title
      else
        @title = document.at("h1").innerHTML.split('<span').first.strip.imdb_unescape_html rescue nil
      end
    end

    # Returns an integer containing the year (CCYY) the movie was released in.
    def year
      document.search('a[@href^="/year/"]').innerHTML.to_i
    end

    # Returns release date for the movie.
    def release_date
      sanitize_release_date(document.search('h5[text()*=Release Date]').first.next_sibling.innerHTML.to_s) rescue nil
    end

    private

    # Returns a new Hpricot document for parsing.
    def document
      @document ||= Hpricot(Imdb::Movie.find_by_id(@id))
    end

    # Use HTTParty to fetch the raw HTML for this movie.
    def self.find_by_id(imdb_id, page = :combined)
      open("http://akas.imdb.com/title/tt#{imdb_id}/#{page}")
    end

    # Convenience method for search
    def self.search(query)
      Imdb::Search.new(query).movies
    end

    def self.top_250
      Imdb::Top250.new.movies
    end

    def sanitize_plot(the_plot)
      the_plot = the_plot.imdb_strip_tags

      the_plot = the_plot.gsub(/add\ssummary|full\ssummary/i, "")
      the_plot = the_plot.gsub(/add\ssynopsis|full\ssynopsis/i, "")
      the_plot = the_plot.gsub(/&nbsp;|&raquo;/i, "")
      the_plot = the_plot.gsub(/see|more/i, "")
      the_plot = the_plot.gsub(/\|/i, "")

      the_plot = the_plot.strip.imdb_unescape_html
    end

    def sanitize_release_date(the_release_date)
      the_release_date = the_release_date.gsub(/<a.*a>/,"")
      the_release_date = the_release_date.gsub(/&nbsp;|&raquo;/i, "")
      the_release_date = the_release_date.gsub(/see|more/i, "")

      the_release_date = the_release_date.strip.imdb_unescape_html
    end

  end # Movie

end # Imdb
